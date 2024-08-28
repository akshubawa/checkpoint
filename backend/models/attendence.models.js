const mongoose = require("mongoose");

const attendenceSchema = new mongoose.Schema({
  date: {
    type: Date,
    default: Date.now,
  },
  userData: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "user",
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
  isLate: {
    type: Boolean,
    default: false,
  },
  isWentEarly: {
    type: Boolean,
    default: false,
  },
  department: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "department",
    required: true,
  },
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
