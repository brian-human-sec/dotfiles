import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./Login";
import HockeyScores from "./HockeyScores";
import Temperature from "./Temperature";
import Home from "./Home";
import ProtectedRoutes from "./ProtectedRoutes";

export default function AllRoutes() {
  return (
    <div>
      <BrowserRouter>
          <div>
          </div>
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route element={<ProtectedRoutes />}>
              <Route path="/" element={<Home />} />
              <Route path="/nhl" element={<HockeyScores />} />
              <Route path="/temperature" element={<Temperature />} />
            </Route>
          </Routes>
      </BrowserRouter>
    </div>
  );
}
