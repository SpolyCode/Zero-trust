# apps/user-service/main.py
# WHY: Manages user profiles + validates tokens (demo). Exposes health/readiness and OpenTelemetry traces.
from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
import os
import jwt
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor

app = FastAPI()
FastAPIInstrumentor.instrument_app(app)
JWT_SECRET = os.getenv("JWT_SECRET", "devsecret")

class Profile(BaseModel):
    username: str
    email: str = "demo@sentinel.local"

@app.get("/health")
def health():
    return {"status":"ok"}

@app.get("/profile")
def profile(request: Request):
    auth = request.headers.get("authorization")
    if not auth: raise HTTPException(status_code=401, detail="no auth")
    try:
        token = auth.split()[1]
        payload = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        return {"username": payload.get("sub"), "email":"demo@sentinel.local"}
    except Exception:
        raise HTTPException(status_code=401, detail="invalid token")
