const mongoose = require("mongoose");

const offsideLocationsSchema = new mongoose.Schema({
  officeId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "office",
  },
  //   officeName: {
  //     type: String,
  //     required: true,
  //     unique: true,
  //   },
  name: {
    type: String,
    required: true,
  },
  // address:{
  //     type:String,
  //     required:true,
  // },
  // city:{
  //     type:String,
  //     required:true,
  // },
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
});

module.exports = mongoose.model("offsideLocations", offsideLocationsSchema);
