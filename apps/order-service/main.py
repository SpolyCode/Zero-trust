# apps/order-service/main.py
# WHY: Accepts orders, verifies user via User Service, stores in-memory (demo).
from fastapi import FastAPI, Request, HTTPException
from pydantic import BaseModel
import httpx
import os
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor

app = FastAPI()
FastAPIInstrumentor.instrument_app(app)
USER_SVC = os.getenv("USER_SVC", "http://user-service:8000")
orders = []
class OrderReq(BaseModel):
    productId: str

@app.get("/health")
def health():
    return {"status":"ok"}

@app.post("/orders")
async def create_order(request: Request, body: OrderReq):
    # Validate user by calling User Service (mTLS + SPIFFE in mesh)
    auth = request.headers.get("authorization")
    if not auth: raise HTTPException(status_code=401, detail="missing auth")
    async with httpx.AsyncClient() as client:
        r = await client.get(f"{USER_SVC}/profile", headers={"authorization": auth}, timeout=5.0)
        if r.status_code != 200:
            raise HTTPException(status_code=401, detail="user validation failed")
    order = {"id": len(orders)+1, "productId": body.productId}
    orders.append(order)
    return order
