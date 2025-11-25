// apps/frontend/src/main.jsx
// Simple React frontend: Produktliste + Bestellungen.
// WHY: Demo UI so reviewers can create orders and see JWT auth flow.
import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";

createRoot(document.getElementById("root")).render(<App />);
