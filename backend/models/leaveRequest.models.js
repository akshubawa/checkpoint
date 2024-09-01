const mongoose = require("mongoose");

const leaveRequestSchema = new mongoose.Schema({
  employee: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Employee",
    required: true,
  },
  attendance: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Attendence",
    required: true,
  },
  exitTime: {
    type: Date,
    required: true,
  },
  returnTime: {
    type: Date,
  },
  reason: {
    type: String,
    required: true,
  },
  isApprovedByAdmin: {
    type: Boolean,
    default: false,
  },
});

module.exports = mongoose.model("LeaveRequest", leaveRequestSchema);
