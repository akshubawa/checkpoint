import React, { useState, useEffect } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, LineChart, Line, PieChart, Pie, Cell } from 'recharts';

const AdminDashboard = () => {
  const [stats, setStats] = useState({
    totalEmployees: 0,
    presentToday: 0,
    totalOffices: 0,
    pendingOffSiteRequests: 0,
    avgCheckInTime: '',
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
      avgCheckInTime: '09:15 AM',
      lateCheckInsPercentage: 12,
      earlyCheckOutsPercentage: 8,
    });
  };

  const fetchAttendanceData = async () => {
    // Simulating API call
    setAttendanceData([
      { date: '2023-05-01', present: 140, absent: 10, offsite: 5 },
      { date: '2023-05-02', present: 138, absent: 12, offsite: 7 },
      { date: '2023-05-03', present: 135, absent: 15, offsite: 6 },
      { date: '2023-05-04', present: 132, absent: 18, offsite: 8 },
      { date: '2023-05-05', present: 130, absent: 20, offsite: 9 },
    ]);
  };

  const fetchOffSiteRequests = async () => {
    // Simulating API call
    setOffSiteRequests([
      { _id: '1', employee: { firstName: 'John', lastName: 'Doe', employeeId: 'EMP001' }, date: '2023-05-06', type: 'Work From Home', reason: 'Family emergency' },
      { _id: '2', employee: { firstName: 'Jane', lastName: 'Smith', employeeId: 'EMP002' }, date: '2023-05-07', type: 'Offsite Meeting', reason: 'Client meeting' },
    ]);
  };

  const fetchMonthlyAttendance = async () => {
    // Simulating API call
    setMonthlyAttendance([
      { month: 'Jan', attendanceRate: 95 },
      { month: 'Feb', attendanceRate: 97 },
      { month: 'Mar', attendanceRate: 94 },
      { month: 'Apr', attendanceRate: 96 },
      { month: 'May', attendanceRate: 93 },
    ]);
  };

  const fetchDepartmentAttendance = async () => {
    // Simulating API call
    setDepartmentAttendance([
      { department: 'IT', attendanceRate: 97 },
      { department: 'HR', attendanceRate: 95 },
      { department: 'Finance', attendanceRate: 98 },
      { department: 'Marketing', attendanceRate: 94 },
      { department: 'Operations', attendanceRate: 96 },
    ]);
  };

  const fetchOffSiteReasons = async () => {
    // Simulating API call
    setOffSiteReasons([
      { reason: 'Work From Home', value: 45 },
      { reason: 'Client Meeting', value: 30 },
      { reason: 'Conference', value: 15 },
      { reason: 'Training', value: 10 },
    ]);
  };

  const handleApproveRequest = async (id) => {
    console.log('Approved request:', id);
    // Implement approve logic here
  };

  const handleRejectRequest = async (id) => {
    console.log('Rejected request:', id);
    // Implement reject logic here
  };

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042'];

  return (
    <div className="flex h-screen bg-gray-100">
      {/* Sidebar */}
      <div className="hidden md:flex md:flex-shrink-0">
        {/* ... (sidebar content remains the same) */}
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
                        <svg className="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">Total Employees</dt>
                          <dd className="text-3xl font-semibold text-gray-900">{stats.totalEmployees}</dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-green-500 rounded-md p-3">
                        <svg className="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">Present Today</dt>
                          <dd className="text-3xl font-semibold text-gray-900">{stats.presentToday}</dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-yellow-500 rounded-md p-3">
                        <svg className="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">Avg Check-in Time</dt>
                          <dd className="text-3xl font-semibold text-gray-900">{stats.avgCheckInTime}</dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-white overflow-hidden shadow rounded-lg">
                  <div className="p-5">
                    <div className="flex items-center">
                      <div className="flex-shrink-0 bg-red-500 rounded-md p-3">
                        <svg className="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                      </div>
                      <div className="ml-5 w-0 flex-1">
                        <dl>
                          <dt className="text-sm font-medium text-gray-500 truncate">Late Check-ins</dt>
                          <dd className="text-3xl font-semibold text-gray-900">{stats.lateCheckInsPercentage}%</dd>
                        </dl>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* Rest of the dashboard content */}
              {/* ... (Charts and tables remain the same) */}
            </div>
          </div>
        </main>
      </div>
    <div className="flex h-screen bg-gray-100">
      {/* Sidebar */}
      <div className="hidden md:flex md:flex-shrink-0">
        <div className="flex flex-col w-64 bg-gray-800">
          <div className="flex items-center h-16 px-4 bg-gray-900">
            <span className="text-white font-semibold">Admin Dashboard</span>
          </div>
          <nav className="mt-5 flex-1 px-2 bg-gray-800">
            <a href="#" className="group flex items-center px-2 py-2 text-sm leading-5 font-medium text-white rounded-md bg-gray-900 focus:outline-none focus:bg-gray-700 transition ease-in-out duration-150">
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
                {/* Stat cards - same as before */}
                {/* ... */}
              </div>

              {/* Attendance Chart */}
              <div className="mt-8">
                <h3 className="text-lg leading-6 font-medium text-gray-900">Weekly Attendance</h3>
                <div className="mt-5">
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={attendanceData}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="date" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="present" name="Present" fill="#8884d8" />
                      <Bar dataKey="absent" name="Absent" fill="#82ca9d" />
                      <Bar dataKey="offsite" name="Off-site" fill="#ffc658" />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Monthly Attendance Trend */}
              <div className="mt-8">
                <h3 className="text-lg leading-6 font-medium text-gray-900">Monthly Attendance Trend</h3>
                <div className="mt-5">
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={monthlyAttendance}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="month" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Line type="monotone" dataKey="attendanceRate" stroke="#8884d8" />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Department-wise Attendance */}
              <div className="mt-8">
                <h3 className="text-lg leading-6 font-medium text-gray-900">Department-wise Attendance</h3>
                <div className="mt-5">
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={departmentAttendance} layout="vertical">
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis type="number" />
                      <YAxis dataKey="department" type="category" />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="attendanceRate" fill="#8884d8" />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Off-site Work Reasons */}
              <div className="mt-8">
                <h3 className="text-lg leading-6 font-medium text-gray-900">Off-site Work Reasons</h3>
                <div className="mt-5">
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={offSiteReasons}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {offSiteReasons.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip />
                      <Legend />
                    </PieChart>
                  </ResponsiveContainer>
                </div>
              </div>

              {/* Off-site Work Requests */}
              <div className="mt-8">
                <h3 className="text-lg leading-6 font-medium text-gray-900">Pending Off-site Work Requests</h3>
                <div className="mt-5">
                  <div className="flex flex-col">
                    <div className="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                      <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                        <div className="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
                          <table className="min-w-full divide-y divide-gray-200">
                            <thead className="bg-gray-50">
                              <tr>
                                <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Employee</th>
                                <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                                <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Reason</th>
                                <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                              </tr>
                            </thead>
                            <tbody className="bg-white divide-y divide-gray-200">
                              {offSiteRequests.map((request) => (
                                <tr key={request._id}>
                                  <td className="px-6 py-4 whitespace-nowrap">
                                    <div className="text-sm font-medium text-gray-900">{request.employee.firstName} {request.employee.lastName}</div>
                                    <div className="text-sm text-gray-500">{request.employee.employeeId}</div>
                                  </td>
                                  <td className="px-6 py-4 whitespace-nowrap">
                                    <div className="text-sm text-gray-900">{request.date}</div>
                                  </td>
                                  <td className="px-6 py-4 whitespace-nowrap">
                                    <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                      {request.type}
                                    </span>
                                  </td>
                                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{request.reason}</td>
                                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <button onClick={() => handleApproveRequest(request._id)} className="text-indigo-600 hover:text-indigo-900 mr-4">Approve</button>
                                    <button onClick={() => handleRejectRequest(request._id)} className="text-red-600 hover:text-red-900">Reject</button>
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
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
