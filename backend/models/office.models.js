const mongoose = require("mongoose");

const officeSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      require: true,
      trim: true,
    },
    address: {
      type: String,
      require: true,
    },
    coordinates: {
      latitudes: {
        type: String,
        required: true,
      },
      longitudes: {
        type: String,
        required: true,
      },
    },
    radius: {
      type: Number,
      default: 200,
    },
    allDepartments: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "department",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("office", officeSchema);
