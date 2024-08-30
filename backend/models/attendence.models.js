const mongoose = require("mongoose");

const attendenceSchema = new mongoose.Schema({
  date: {
    type: Date,
    default: Date.now,
  },
  employee: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "employee",
    required: true,
  },
  checkInTime: {
    type: String,
    required: true,
  },
  checkOutTime: {
    type: String,
    required: true,
  },
  isLateCheckIn: {
    type: Boolean,
    default: false,
  },
  isEarlyCheckout: {
    type: Boolean,
    default: false,
  },
  officeExitRecords: [{
    exitTime: Date,
    returnTime: Date,
    reason: String
  }],
  totalWorkingHours: {
    type: Number
  }
});

attendenceSchema.pre("save", async function (next) {
  const attendence = this;

  const department = await mongoose
    .model("department")
    .findById(attendence.department);

  if (department) {
    if (attendence.checkInTime > department.expectedCheckIntime) {
      attendence.isLate = true;
    } else {
      attendence.isLate = false;
    }
  }

  if (attendence.checkOutTime < department.expectedCheckOutTime) {
    attendence.isWentEarly = true;
  } else {
    attendence.isWentEarly = false;
  }
});

module.exports = mongoose.model("attendence", attendenceSchema);
