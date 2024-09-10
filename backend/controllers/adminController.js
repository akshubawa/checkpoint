const Employee = require("../models/employee.models");
const AttendenceSchema = require("../models/attendence.models");
const Office = require("../models/office.models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const LeaveRequest = require("../models/leaveRequest.models");

exports.adminLogin = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Please enter all the fields.",
      });
    }

    const employee = await Employee.findOne({ email });

    if (!employee) {
      return res.status(400).json({
        success: false,
        message: "Invalid credentials.",
      });
    }

    if (employee.role !== "admin") {
      return res.status(400).json({
        success: false,
        message: "You are not authorized to access this",
      });
    }

    try {
      const isMatch = await bcrypt.compare(password, employee.password);

      if (!isMatch) {
        return res.status(403).json({
          success: false,
          message: "Invalid password.",
        });
      }

      const token = jwt.sign(
        { id: employee._id, email: employee.email, role: employee.role },
        process.env.JWT_SECRET,
        { expiresIn: "7d" }
      );

      return res.status(200).json({
        success: true,
        message: "Login successful.",
        token: token,
      });
    } catch (err) {
      return res.status(500).json({
        success: false,
        message: "Error occurred while logging in.",
        error: err.message,
      });
    }
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while logging in.",
      error: err.message,
    });
  }
};

exports.getTotalEmployees = async (req, res) => {
  try {
    const { id } = req.user;
    console.log(id);

    const user = await Employee.findById(id);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "No user is found with this id.",
      });
    }

    const departmentId = user.departmentId;

    const employees = await Employee.find({ departmentId });

    if (!employees) {
      return res.status(403).json({
        success: false,
        message: "No employees found in this department.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Total employees found.",
      data: employees,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while fetching total employees.",
      error: err.message,
    });
  }
};

exports.getPresentToday = async (req, res) => {
  try {
    const { id } = req.user;

    // Find the logged-in user
    const user = await Employee.findById(id);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "No user is found with this ID.",
      });
    }

    const departmentId = user.departmentId;

    // Get today's date in YYYY-MM-DD format
    const today = new Date().toISOString().split("T")[0];

    // Find all employees in the same department
    const employees = await Employee.find({ departmentId });

    if (employees.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No employees found in this department.",
      });
    }

    // Find attendance records for today for all employees in the department
    const presentEmployees = await AttendenceSchema.find({
      employee: { $in: employees.map((emp) => emp._id) },
      date: {
        $gte: new Date(today),
        $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
      },
      checkInTime: { $ne: null }, // Ensures the employee has checked in
    }).populate("employee", "name email");

    if (presentEmployees.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No employees are present today in this department.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Present employees fetched successfully.",
      presentEmployees,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while fetching present employees.",
      error: err.message,
    });
  }
};

exports.adminGetAllOffices = async (req, res) => {
  try {
    const offices = await Office.find();

    if (offices.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No offices found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Offices fetched successfully.",
      data: offices,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while fetching offices.",
      error: err.message,
    });
  }
};

exports.getAllHalfDayLeaveRequests = async (req, res) => {
  try {
    const leaveRequests = await LeaveRequest.find({}); // Fetch all leave requests

    if (!leaveRequests || leaveRequests.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No half-day leave requests found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Half-day leave requests retrieved successfully.",
      leaveRequests,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while fetching half-day leave requests.",
      error: err.message,
    });
  }
};
