// apps/frontend/src/App.jsx
import React, { useEffect, useState } from "react";
import axios from "axios";

const API = process.env.REACT_APP_API_URL || "/api";

export default function App() {
  const [products] = useState([
    { id: "p1", name: "Sentinel T-shirt", price: 19 },
    { id: "p2", name: "Sentinel Mug", price: 9 },
  ]);
  const [token, setToken] = useState("");
  const [orders, setOrders] = useState([]);

  async function login() {
    // demo login: call API Gateway /auth/login -> receive JWT
    const res = await axios.post(`${API}/auth/login`, { username: "demo", password: "demo" });
    setToken(res.data.token);
  }

  async function createOrder(productId) {
    if (!token) return alert("Bitte einloggen");
    const res = await axios.post(`${API}/orders`, { productId }, { headers: { Authorization: `Bearer ${token}` }});
    setOrders([...orders, res.data]);
  }

  useEffect(()=>{ /* load orders if logged in */ }, [token]);
  return (
    <div style={{padding:20}}>
      <h1>SentinelSecurity Store</h1>
      <button onClick={login}>Login (demo)</button>
      <h2>Products</h2>
      {products.map(p => (
        <div key={p.id}>
          <b>{p.name}</b> - ${p.price} <button onClick={()=>createOrder(p.id)}>Order</button>
        </div>
      ))}
      <h2>Orders</h2>
      {orders.map((o,i) => <div key={i}>Order #{o.id} - {o.productId}</div>)}
    </div>
  );
}
