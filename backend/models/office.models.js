const mongoose = require("mongoose");

const officeSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    address: {
      type: String,
      required: true,
      trim: true,
    },
    city: {
      type: String,
      required: true,
      trim: true,
    },
    state: {
      type: String,
      required: true,
      trim: true,
    },
    country: {
      type: String,
      required: true,
      trim: true,
    },
    zipCode: {
      type: String,
      required: true,
      trim: true,
    },
    coordinates: {
      latitude: {
        type: Number,
        required: true,
      },
      longitude: {
        type: Number,
        required: true,
      },
    },
    radius: {
      type: Number,
      required: true,
      default: 200, // in meters
    },
    isActive: {
      type: Boolean,
      default: false,
    },
    allDepartments: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "department",
      },
    ],
    allOffsideLocations: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "offsideLocations",
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("office", officeSchema);
