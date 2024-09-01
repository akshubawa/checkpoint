"use client";
import { basePath } from "@/components/route";
import React, { useEffect, useState } from "react";

const Page = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  // @ts-ignore
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const response = await fetch(`${basePath}/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          identifier: email,
          password,
          deviceInfo: {
            platform: "android",
            deviceToken: "thisisdevicetoken",
          },
        }),
      });

      const data = await response.json();

      if (data.success) {
        localStorage.setItem("adminToken", data.token);
        window.location.href = "/";
      } else {
        setError(data.message);
      }
    } catch (error) {
      setError("An error occurred. Please try again.");
    }
  };

  useEffect(() => {
    const getToken = async () => {
      const token = localStorage.getItem("adminToken");
      if (token) {
        window.location.href = "/";
      }
    };
    getToken();
  }, []);

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Login Form */}
      <div className="w-1/3 flex items-center justify-center">
        <div className="w-full h-full flex flex-col items-center justify-center space-y-8 p-10 bg-white rounded-xl shadow-lg">
          <div>
            <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
              Sign in to Admin Dashboard
            </h2>
          </div>
          <form className="mt-8 w-[80%] space-y-6" onSubmit={handleSubmit}>
            <div className="rounded-md flex flex-col gap-4 shadow-sm -space-y-px">
              <div className="">
                <label htmlFor="email-address" className="sr-only">
                  Email address
                </label>
                <input
                  id="email-address"
                  name="email"
                  type="email"
                  autoComplete="email"
                  required
                  className="appearance-none  relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder="Email address"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                />
              </div>
              <div>
                <label htmlFor="password" className="sr-only">
                  Password
                </label>
                <input
                  id="password"
                  name="password"
                  type="password"
                  autoComplete="current-password"
                  required
                  className="appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                  placeholder="Password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
              </div>
            </div>

            {/* <div className="flex items-center justify-between">
              <div className="text-sm">
                <a
                  href="#"
                  className="font-medium text-indigo-600 hover:text-indigo-500"
                >
                  Forgot your password?
                </a>
              </div>
            </div> */}

            {error && (
              <div className="text-red-600 text-sm text-center">{error}</div>
            )}

            <div>
              <button
                type="submit"
                className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                Sign in
              </button>
            </div>
          </form>
        </div>
      </div>

      {/* Curved Image Container */}
      <div className="w-2/3 bg-gray-200 rounded-l-3xl overflow-hidden">
        <div className="h-full w-full p-8">
          <div className="h-full w-full bg-white rounded-3xl overflow-hidden shadow-xl">
            <div className="h-full w-full grid grid-cols-3 grid-rows-3 gap-2 p-2">
              <div className="row-span-1 col-span-1 bg-gray-200 rounded-lg"></div>
              <div className="row-span-1 col-span-2 bg-red-500 rounded-lg flex items-center justify-center text-white text-2xl font-bold p-4">
                <p>
                  41% of recruiters say entry-level positions are the hardest to
                  fill.
                </p>
              </div>
              <div className="row-span-2 col-span-1 bg-gray-200 rounded-lg"></div>
              <div className="row-span-1 col-span-1 bg-gray-200 rounded-lg"></div>
              <div className="row-span-2 col-span-1 bg-gray-200 rounded-lg"></div>
              <div className="row-span-1 col-span-2 bg-green-500 rounded-lg flex items-center justify-center text-white text-2xl font-bold p-4">
                <p>
                  76% of hiring managers admit attracting the right job
                  candidates is their greatest challenge.
                </p>
              </div>
              <div className="row-span-1 col-span-1 bg-gray-200 rounded-lg"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Page;
