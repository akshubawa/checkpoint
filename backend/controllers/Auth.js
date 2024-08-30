const User = require("../models/employee.models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

// Signup Route
exports.signup = async (req, res) => {
  const {
    firstName,
    lastName,
    email,
    password,
    employeeId,
    isActive,
    department,
    allAttendence,
  } = req.body;

  try {
    // Check if user already exists
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ msg: "User already exists" });
    }

    // Create a new user
    user = new User({
      firstName,
      lastName,
      email,
      password, // Password will be hashed before saving due to the pre-save hook in the model
      employeeId,
      isActive,
      department, // Assign department to the user
      allAttendence, // Assign allAttendence to the user
    });

    await user.save();
    res.status(201).json({ msg: "User registered successfully" });
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server error");
  }
};

// Login Route
exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Find user by email
    let user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Check if the user is active
    if (!user.isActive) {
      return res.status(403).json({
        msg: "Account is inactive. Please contact your administrator.",
      });
    }

    // Check password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Generate JWT
    const payload = {
      user: {
        id: user.id,
      },
    };

    jwt.sign(
      payload,
      "your_jwt_secret", // Replace with your actual secret key, ideally stored in environment variables
      { expiresIn: "1h" },
      (err, token) => {
        if (err) throw err;
        res.json({ token });
      }
    );
  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server error");
  }
};
