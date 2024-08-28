const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    firstName: {
      type: String,
      required: true,
      trim: true,
    },
    lastName: {
      type: String,
      required: true,
      trim: true,
    },
    email: {
      type: String,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    employeeId: {
      type: String,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    department: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "department",
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

module.exports = mongoose.model("user", userSchema);
