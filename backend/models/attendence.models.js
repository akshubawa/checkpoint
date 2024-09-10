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
    type: Date,
    // required: true,
  },
  checkOutTime: {
    type: Date,
    // required: true,
  },
  isLateCheckIn: {
    type: Boolean,
    default: false,
  },
  isEarlyCheckout: {
    type: Boolean,
    default: false,
  },
  officeExitRecords: [
    {
      flag: Boolean,
      exitTime: Date,
      returnTime: Date,
      reason: "string",
      isApprovedByAdmin: Boolean,
    },
  ],
  totalWorkingHours: {
    type: Number,
  },
});

// attendenceSchema.pre("save", async function (next) {
//   const attendence = this;

//   const department = await mongoose
//     .model("department")
//     .findById(attendence.department);

//   if (department) {
//     if (attendence.checkInTime > department.expectedCheckIntime) {
//       attendence.isLateCheckIn = true;
//     } else {
//       attendence.isLateCheckIn = false;
//     }
//   }

//   if (attendence.checkOutTime < department.expectedCheckOutTime) {
//     attendence.isEarlyCheckout = true;
//   } else {
//     attendence.isEarlyCheckout = false;
//   }
// });

module.exports = mongoose.model("attendence", attendenceSchema);
