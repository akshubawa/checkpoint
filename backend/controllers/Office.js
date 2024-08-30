const Office = require("../models/office.models");
const Department = require("../models/department.models");

exports.createOffice = async (req, res) => {
  try {
    const {
      name,
      address,
      city,
      state,
      country,
      zipCode,
      coordinates,
      radius,
    } = req.body;

    if (
      !name ||
      !address ||
      !city ||
      !state ||
      !country ||
      !zipCode ||
      !coordinates.latitude || // Changed to 'latitude'
      !coordinates.longitude || // Changed to 'longitude'
      !radius
    ) {
      return res.status(400).json({
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

    const newOffice = new Office({
      name,
      address,
      city,
      state,
      country,
      coordinates: {
        latitude: coordinates.latitude, // Changed to 'latitude'
        longitude: coordinates.longitude, // Changed to 'longitude'
      },
      zipCode,
      radius,
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
      message: "Error occurred while creating an office",
      error: err.message,
    });
  }
};

exports.updateOffice = async (req, res) => {
  try {
    const { id } = req.body;
    const { name, address, coordinates, radius, city, country, zipCode } =
      req.body;

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
    if (city) office.city = city;
    if (country) office.country = country;
    if (zipCode) office.zipCode = zipCode;

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

exports.createDepartment = async (req, res) => {
  try {
    const {
      name,
      officeId,
      description,
      expectedCheckInTime,
      expectedCheckOutTime,
      workingDays,
    } = req.body;

    if (
      !officeId ||
      !name ||
      !description ||
      !expectedCheckInTime ||
      !expectedCheckOutTime ||
      !workingDays
    ) {
      return res.status(400).json({
        success: false,
        message: "Please enter all the fields.",
      });
    }

    const office = await Office.findById(officeId);

    if (!office) {
      return res.status(500).json({
        sucess: false,
        message: "No office found with this id.",
      });
    }

    const department = await Department.findOne({ name });

    if (department) {
      return res.status(400).json({
        success: false,
        message: "Department already exists.",
      });
    }

    const newDepartment = new Department({
      name,
      description,
      office: officeId,
      expectedCheckInTime,
      expectedCheckOutTime,
      workingDays,
    });

    await newDepartment.save();

    office.allDepartments.push(newDepartment._id);

    await office.save();

    return res.status(200).json({
      success: true,
      message: "Department created successfully.",
      department: newDepartment,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while creating the department",
      error: err.message,
    });
  }
};

exports.updateDepartment = async (req, res) => {
  try {
    // const { id } = req.body;
    const {
      id,
      name,
      description,
      expectedCheckInTime,
      expectedCheckOutTime,
      workingDays,
    } = req.body;

    const department = await Department.findById(id);

    if (!department) {
      return res.status(500).json({
        success: false,
        message: "Department not found.",
      });
    }

    if (name) department.name = name;
    if (description) department.description = description;
    if (expectedCheckInTime)
      department.expectedCheckInTime = expectedCheckInTime;
    if (expectedCheckOutTime)
      department.expectedCheckOutTime = expectedCheckOutTime;
    if (workingDays) department.workingDays = workingDays;

    await department.save();

    return res.status(200).json({
      success: true,
      message: "Department details updated successfully",
      department: department,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while updating the department",
      error: err.message,
    });
  }
};

exports.getDepartmentDetails = async (req, res) => {
  try {
    const { id } = req.body;

    const department = await Department.findById(id).populate("allUser").exec();

    if (!department) {
      return res.status(500).json({
        success: false,
        message: "Department not found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Department details retrived successfully.",
      department: department,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while getting the details for the department.",
      error: err.message,
    });
  }
};
