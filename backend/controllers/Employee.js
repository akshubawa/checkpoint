const Joi = require("joi");

const deviceInfoSchema = Joi.object({
  platform: Joi.string().required(), // Removed enum validation
  deviceToken: Joi.string().required(),
});

const jwt = require("jsonwebtoken");
const Employee = require("../models/employee.models");

exports.sendDeviceToken = async (req, res) => {
  const token = req.headers.authorization?.split(" ")[1];

  if (!token) {
    return res.status(401).json({
      success: false,
      message: "Authorization token missing.",
    });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const employeeId = decoded.id;

    const { error, value } = deviceInfoSchema.validate(req.body);

    if (error) {
      return res.status(400).json({
        success: false,
        message: error.details[0].message,
      });
    }

    const employee = await Employee.findById(employeeId);

    if (!employee) {
      return res.status(404).json({
        success: false,
        message: "Employee not found.",
      });
    }

    employee.deviceInfo = value;

    await employee.save();

    return res.status(200).json({
      success: true,
      message: "Device info updated successfully.",
      deviceInfo: employee.deviceInfo,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while updating device info.",
      error: err.message,
    });
  }
};
