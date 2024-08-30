const Employee = require("../models/employee.models");

const jwt = require("jsonwebtoken");

const bcrypt = require("bcrypt");

exports.auth = async (req, res, next) => {
  try {
    const token =
      req.body.token || req.header("Authorization").replace("Bearer ", "");

    if (!token) {
      return res.status(400).json({
        success: false,
        message: "Token is required.",
      });
    }

    try {
      const decode = jwt.verify(token, process.env.JWT_SECRET);
      console.log("this is the decode ", decode);
      req.user = decode; // Attach the decoded user information to the request object
    } catch (err) {
      // If token verification fails
      return res.status(401).json({
        success: false,
        message: "Token is invalid",
      });
    }

    next(); // Pass control to the next middleware or route handler
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};
