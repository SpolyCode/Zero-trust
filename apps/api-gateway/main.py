# apps/api-gateway/main.py
# WHY: Entrypoint for external clients. Handles JWT issuance (demo), validation and proxies requests to services.
from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse
import httpx
import os
import jwt
from pydantic import BaseModel
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry import trace

app = FastAPI()
FastAPIInstrumentor.instrument_app(app)
tracer = trace.get_tracer(__name__)

JWT_SECRET = os.getenv("JWT_SECRET", "devsecret")
USER_SVC = os.getenv("USER_SVC", "http://user-service:8000")
ORDER_SVC = os.getenv("ORDER_SVC", "http://order-service:8000")

class LoginReq(BaseModel):
    username: str
    password: str

@app.get("/health")
def health():
    return {"status":"ok"}

@app.post("/auth/login")
async def login(req: LoginReq):
    # DEMO: Simple username/password. In prod connect to identity provider (OIDC).
    if req.username == "demo" and req.password=="demo":
        token = jwt.encode({"sub":req.username}, JWT_SECRET, algorithm="HS256")
        return {"token": token}
    raise HTTPException(status_code=401, detail="invalid credentials")

@app.post("/orders")
async def create_order(request: Request):
    # extract and forward JWT to Order service
    auth = request.headers.get("authorization")
    if not auth:
        raise HTTPException(status_code=401, detail="missing auth")
    headers = {"authorization": auth}
    async with httpx.AsyncClient() as client:
        r = await client.post(f"{ORDER_SVC}/orders", headers=headers, json=await request.json(), timeout=10.0)
    return JSONResponse(status_code=r.status_code, content=r.json())
