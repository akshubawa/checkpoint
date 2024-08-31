import React, { useState, useEffect } from "react";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  LineChart,
  Line,
  PieChart,
  Pie,
  Cell,
} from "recharts";

const AdminDashboard = () => {
  const [stats, setStats] = useState({
    totalEmployees: 0,
    presentToday: 0,
    totalOffices: 0,
    pendingOffSiteRequests: 0,
    avgCheckInTime: "",
    lateCheckInsPercentage: 0,
    earlyCheckOutsPercentage: 0,
  });

  const [attendanceData, setAttendanceData] = useState([]);
  const [offSiteRequests, setOffSiteRequests] = useState([]);
  const [monthlyAttendance, setMonthlyAttendance] = useState([]);
  const [departmentAttendance, setDepartmentAttendance] = useState([]);
  const [offSiteReasons, setOffSiteReasons] = useState([]);

  useEffect(() => {
    fetchDashboardData();
    fetchAttendanceData();
    fetchOffSiteRequests();
    fetchMonthlyAttendance();
    fetchDepartmentAttendance();
    fetchOffSiteReasons();
  }, []);

  const fetchDashboardData = async () => {
    // Simulating API call
    setStats({
      totalEmployees: 150,
      presentToday: 132,
      totalOffices: 5,
      pendingOffSiteRequests: 8,
      avgCheckInTime: "09:15 AM",
      lateCheckInsPercentage: 12,
      earlyCheckOutsPercentage: 8,
    });
  };

  const fetchAttendanceData = () => {
    // Simulating API call
    setAttendanceData([
      { date: "2023-05-01", present: 140, absent: 10, offsite: 5 },
      { date: "2023-05-02", present: 138, absent: 12, offsite: 7 },
      { date: "2023-05-03", present: 135, absent: 15, offsite: 6 },
      { date: "2023-05-04", present: 132, absent: 18, offsite: 8 },
      { date: "2023-05-05", present: 130, absent: 20, offsite: 9 },
    ]);
  };

  const fetchOffSiteRequests = () => {
    // Simulating API call
    setOffSiteRequests([
      {
        _id: "1",
        employee: { firstName: "John", lastName: "Doe", employeeId: "EMP001" },
        date: "2023-05-06",
        type: "Work From Home",
        reason: "Family emergency",
      },
      {
        _id: "2",
        employee: {
          firstName: "Jane",
          lastName: "Smith",
          employeeId: "EMP002",
        },
        date: "2023-05-07",
        type: "Offsite Meeting",
        reason: "Client meeting",
      },
    ]);
  };

  const fetchMonthlyAttendance = () => {
    // Simulating API call
    setMonthlyAttendance([
      { month: "Jan", attendanceRate: 95 },
      { month: "Feb", attendanceRate: 97 },
      { month: "Mar", attendanceRate: 94 },
      { month: "Apr", attendanceRate: 96 },
      { month: "May", attendanceRate: 93 },
    ]);
  };

  const fetchDepartmentAttendance = () => {
    // Simulating API call
    setDepartmentAttendance([
      { department: "IT", attendanceRate: 97 },
      { department: "HR", attendanceRate: 95 },
      { department: "Finance", attendanceRate: 98 },
      { department: "Marketing", attendanceRate: 94 },
      { department: "Operations", attendanceRate: 96 },
    ]);
  };

  const fetchOffSiteReasons = () => {
    // Simulating API call
    setOffSiteReasons([
      { reason: "Work From Home", value: 45 },
      { reason: "Client Meeting", value: 30 },
      { reason: "Conference", value: 15 },
      { reason: "Training", value: 10 },
    ]);
  };

  const handleApproveRequest = async (id) => {
    console.log("Approved request:", id);
    // Implement approve logic here
  };

  const handleRejectRequest = async (id) => {
    console.log("Rejected request:", id);
    // Implement reject logic here
  };

  const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042"];

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Sidebar */}
      <div className="hidden md:flex md:flex-shrink-0">
        <div className="flex flex-col w-64 bg-gray-800">
          <div className="flex items-center h-16 px-4 bg-gray-900">
            <span className="text-white font-semibold">Admin Dashboard</span>
          </div>
          <nav className="mt-5 flex-1 px-2 bg-gray-800">
            <a
              href="#"
              className="group flex items-center px-2 py-2 text-sm leading-5 font-medium text-white rounded-md bg-gray-900 focus:outline-none focus:bg-gray-700 transition ease-in-out duration-150"
            >
              Dashboard
            </a>
            {/* Add more nav items here */}
          </nav>
        </div>
      </div>

      {/* Main content */}
      <div className="flex-1 overflow-auto focus:outline-none">
        <main className="flex-1 relative pb-8 z-0 overflow-y-auto">
          {/* Page header */}
          <div className="bg-white shadow">
            <div className="px-4 sm:px-6 lg:max-w-6xl lg:mx-auto lg:px-8">
              <div className="py-6 md:flex md:items-center md:justify-between lg:border-t lg:border-gray-200">
                <div className="flex-1 min-w-0">
                  <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
                    Admin Dashboard
                  </h1>
                </div>
              </div>
            </div>
          </div>

          <div className="mt-8">
            <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
              {/* Stats */}
              <div className="mt-2 grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-indigo-500 rounded-md p-3">
                        <svg
                          className="h-6 w-6 text-white"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={2}
                            d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"
                          />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">
                            Total Employees
                          </dt>
                          <dd className="text-3xl font-semibold text-gray-900">
                            {stats.totalEmployees}
                          </dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-green-500 rounded-md p-3">
                        <svg
                          className="h-6 w-6 text-white"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={2}
                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                          />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">
                            Present Today
                          </dt>
                          <dd className="text-3xl font-semibold text-gray-900">
                            {stats.presentToday}
                          </dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-yellow-500 rounded-md p-3">
                        <svg
                          className="h-6 w-6 text-white"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={2}
                            d="M3 10h3l3-7h8l3 7h3M7 13h10M7 16h10M5 19h14M9 10h6M9 13h6M9 16h6M9 19h6M9 22h6"
                          />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">
                            Total Offices
                          </dt>
                          <dd className="text-3xl font-semibold text-gray-900">
                            {stats.totalOffices}
                          </dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-red-500 rounded-md p-3">
                        <svg
                          className="h-6 w-6 text-white"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={2}
                            d="M12 11c0-.552-.448-1-1-1s-1 .448-1 1 .448 1 1 1 1-.448 1-1zm-4 0c0-.552-.448-1-1-1s-1 .448-1 1 .448 1 1 1 1-.448 1-1zm8 0c0-.552-.448-1-1-1s-1 .448-1 1 .448 1 1 1 1-.448 1-1zM12 15c-2.667 0-4 1.333-4 4v2h8v-2c0-2.667-1.333-4-4-4z"
                          />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">
                            Pending Off-Site Requests
                          </dt>
                          <dd className="text-3xl font-semibold text-gray-900">
                            {stats.pendingOffSiteRequests}
                          </dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* Charts Section */}
              <div className="mt-8 grid grid-cols-1 gap-5 sm:grid-cols-2">
                {/* Line Chart for Attendance */}
                <div className="bg-white p-5 shadow rounded-lg">
                  <h3 className="text-lg font-medium leading-6 text-gray-900 mb-3">
                    Attendance Overview
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={attendanceData}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="date" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Line
                        type="monotone"
                        dataKey="present"
                        stroke="#82ca9d"
                      />
                      <Line type="monotone" dataKey="absent" stroke="#8884d8" />
                      <Line
                        type="monotone"
                        dataKey="offsite"
                        stroke="#ffc658"
                      />
                    </LineChart>
                  </ResponsiveContainer>
                </div>

                {/* Pie Chart for Off-Site Reasons */}
                <div className="bg-white p-5 shadow rounded-lg">
                  <h3 className="text-lg font-medium leading-6 text-gray-900 mb-3">
                    Off-Site Reasons
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={offSiteReasons}
                        dataKey="value"
                        nameKey="reason"
                        outerRadius={120}
                        fill="#8884d8"
                      >
                        {offSiteReasons.map((entry, index) => (
                          <Cell
                            key={`cell-${index}`}
                            fill={COLORS[index % COLORS.length]}
                          />
                        ))}
                      </Pie>
                      <Tooltip />
                      <Legend />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Bar Chart for Monthly Attendance */}
              <div className="mt-8 bg-white p-5 shadow rounded-lg">
                <h3 className="text-lg font-medium leading-6 text-gray-900 mb-3">
                  Monthly Attendance
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={monthlyAttendance}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="month" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="attendanceRate" fill="#82ca9d" />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              {/* Department Attendance Rates */}
              <div className="mt-8 bg-white p-5 shadow rounded-lg">
                <h3 className="text-lg font-medium leading-6 text-gray-900 mb-3">
                  Department Attendance Rates
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={departmentAttendance}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="department" />
                    <YAxis />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="attendanceRate" fill="#8884d8" />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              {/* Off-Site Requests Table */}
              <div className="mt-8 bg-white shadow overflow-hidden sm:rounded-lg">
                <div className="px-4 py-5 sm:px-6">
                  <h3 className="text-lg leading-6 font-medium text-gray-900">
                    Pending Off-Site Requests
                  </h3>
                </div>
                <div className="border-t border-gray-200">
                  <dl>
                    {offSiteRequests.map((request) => (
                      <div
                        key={request._id}
                        className="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6"
                      >
                        <dt className="text-sm font-medium text-gray-500">
                          Employee Name
                        </dt>
                        <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                          {request.employee.firstName}{" "}
                          {request.employee.lastName} (
                          {request.employee.employeeId})
                        </dd>
                        <dt className="text-sm font-medium text-gray-500">
                          Date
                        </dt>
                        <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                          {request.date}
                        </dd>
                        <dt className="text-sm font-medium text-gray-500">
                          Request Type
                        </dt>
                        <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                          {request.type}
                        </dd>
                        <dt className="text-sm font-medium text-gray-500">
                          Reason
                        </dt>
                        <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                          {request.reason}
                        </dd>
                        <div className="mt-4 sm:mt-0 sm:col-span-3 flex space-x-4">
                          <button
                            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
                            onClick={() => handleApproveRequest(request._id)}
                          >
                            Approve
                          </button>
                          <button
                            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                            onClick={() => handleRejectRequest(request._id)}
                          >
                            Reject
                          </button>
                        </div>
                      </div>
                    ))}
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
};

export default AdminDashboard;
