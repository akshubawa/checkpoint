const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const employeeSchema = new mongoose.Schema(
  {
    firstName: {
      type: String,
      // required: true,
      trim: true,
    },
    middleName: {
      type: String,
      trim: true,
    },
    lastName: {
      type: String,
      // required: true,
      trim: true,
    },
    email: {
      type: String,
      required: true,
      trim: true,
      unique: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: true,
    },
    employeeId: {
      type: String,
      unique: true,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    departmentName: {
      type: String,
      required: true,
      trim: true,
    },
    departmentId: {
      type: mongoose.Schema.Types.ObjectId,
    },
    role: {
      type: String,
      enum: ["employee", "manager", "admin"],
      default: "employee",
    },
    token: {
      type: String,
    },
    deviceInfo: {
      platform: {
        type: String,
        required: true,
      },
      deviceToken: {
        type: "String",
        required: true,
      },
    },
    allAttendence: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "attendence",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("employee", employeeSchema);
