const User = require("../models/user.models");
const bcrypt = require("bcrypt");

exports.signup = async (req, res) => {
  try {
  } catch (err) {
    console.log(err);
    return res.status(500).json({
      success: false,
      message: "Error occured while signin",
      error: err.message,
    });
  }
};
