const mongoose = require("mongoose");

const departmentSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    description: {
      type: String,
      required: true,
      trim: true,
    },
    office: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Office",
      required: true,
    },
    expectedCheckInTime: {
      type: String,
      required: true,
    },
    expectedCheckOutTime: {
      type: String,
      required: true,
    },
    workingDays: [
      {
        type: String,
        required: true,
      },
    ],
    allUser: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "employee",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("department", departmentSchema);
