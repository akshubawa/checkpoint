"use client";

import AdminDashboard from "@/components/final-admin-dashboard-with-graphs";
import React, { useEffect } from "react";

const Page = () => {
  useEffect(() => {
    const getToken = async () => {
      const token = localStorage.getItem("adminToken");
      if (!token) {
        window.location.href = "/login";
      }
    };
    getToken();

    const getid = async () => {
      console.log(id);
    };
  }, []);

  return (
    <div>
      <AdminDashboard />
    </div>
  );
};

export default Page;
