const Office = require("../models/office.models");

exports.createOffice = async (req, res) => {
  try {
    const { name, address, coordinates } = req.body;

    if (
      !name ||
      !address ||
      !coordinates.latitudes ||
      !coordinates.longitudes
    ) {
      return res.status(200).json({
        success: false,
        message: "Please enter all the fields.",
      });
    }

    const isNameExist = await Office.findOne({ name });

    if (isNameExist) {
      return res.status(400).json({
        success: false,
        message: "Your company is already registered.",
      });
    }

    const newOffice = await Office({
      name,
      address,
      coordinates: {
        latitudes: coordinates.latitudes,
        longitudes: coordinates.longitudes,
      },
    });

    await newOffice.save();

    return res.status(200).json({
      success: true,
      message: "Office created successfully.",
      office: newOffice,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while creating an office",
    });
  }
};

exports.updateOffice = async (req, res) => {
  try {
    const { id } = req.body;
    const { name, address, coordinates, radius } = req.body;

    const office = await Office.findById(id);

    if (!office) {
      return res.status(500).json({
        success: false,
        message: "Office not found.",
      });
    }

    if (name) office.name = name;
    if (address) office.address = address;
    if (coordinates) {
      if (coordinates.latitudes)
        office.coordinates.latitudes = coordinates.latitudes;
      if (coordinates.longitudes)
        office.coordinates.longitudes = coordinates.longitudes;
    }
    if (radius) office.radius = radius;

    await office.save();

    return res.status(200).json({
      success: true,
      message: "office details updated successfully",
      office: office,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while updating the office",
      error: err.message,
    });
  }
};

exports.getOfficeDetails = async (req, res) => {
  try {
    const { id } = req.body;

    const office = await Office.findById(id);

    if (!office) {
      return res.status(500).json({
        success: false,
        message: "Office not found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "office details retrived successfully.",
      office: office,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while getting the details for the office.",
      error: err.message,
    });
  }
};
