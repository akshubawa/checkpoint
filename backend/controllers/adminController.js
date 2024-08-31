const Employee = require("../models/employee.models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

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
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while fetching total employees.",
      error: err.message,
    });
  }
};
