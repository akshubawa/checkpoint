const Employee = require("../models/employee.models");
const Office = require("../models/office.models");
const Department = require("../models/department.models");
const AttendenceSchema = require("../models/attendence.models");

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

exports.getAllOffices = async (req, res) => {
  try {
    const offices = await Office.find();

    if (!offices) {
      return res.status(500).json({
        success: false,
        message: "No office found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "All offices details retrived successfully.",
      offices: offices,
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

exports.getAllDepartments = async (req, res) => {
  try {
    const { officeName } = req.body;

    const office = await Office.findOne({ name: officeName })
      .populate("allDepartments")
      .exec();

    if (!office) {
      return res.status(500).json({
        success: false,
        message: "Office not found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Department details retrived successfully.",
      department: office.allDepartments,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while getting the details for the department.",
      error: err.message,
    });
  }
};

exports.checkIn = async (req, res) => {
  try {
    const { id } = req.user;

    const user = await Employee.findById(id);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "User not found with this id.",
      });
    }

    const departmentId = user.departmentId;
    const department = await Department.findById(departmentId);

    if (!department) {
      return res.status(403).json({
        success: false,
        message: "Department not found with this id.",
      });
    }

    // Get current time
    const currentTime = new Date();

    const newAttendence = new AttendenceSchema({
      employee: id,
      checkInTime: currentTime,
      checkOutTime: null,
    });

    // Check if check-in is late
    if (currentTime > department.expectedCheckInTime) {
      newAttendence.isLateCheckIn = true;
    } else {
      newAttendence.isLateCheckIn = false;
    }

    await newAttendence.save();

    user.allAttendence.push(newAttendence._id);
    await user.save();

    return res.status(200).json({
      success: true,
      message: "Checked in successfully.",
      attendence: newAttendence,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while checking in",
      error: err.message,
    });
  }
};

exports.checkOut = async (req, res) => {
  try {
    const { id } = req.user;

    // Find the user
    const user = await Employee.findById(id);
    if (!user) {
      return res.status(403).json({
        success: false,
        message: "User not found with this id.",
      });
    }

    // Find the attendance record for today
    const today = new Date().toISOString().split("T")[0]; // YYYY-MM-DD format
    console.log("this is the today date:: ", today);
    const attendence = await AttendenceSchema.findOne({
      employee: id,
      date: {
        $gte: new Date(today),
        $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
      },
    });

    console.log("this is the attendance:: ", attendence);

    if (!attendence) {
      return res.status(404).json({
        success: false,
        message: "No attendance record found for today.",
      });
    }

    // Get current time
    const currentTime = new Date();

    // Ensure checkInTime is a Date object
    const checkInTime = new Date(attendence.checkInTime);

    if (isNaN(checkInTime.getTime())) {
      throw new Error("Invalid check-in time format.");
    }

    // Update checkout time
    attendence.checkOutTime = currentTime;

    // Calculate total working hours
    const workingHours = (currentTime - checkInTime) / (1000 * 60 * 60); // in hours

    if (isNaN(workingHours)) {
      throw new Error("Invalid working hours calculation.");
    }

    attendence.totalWorkingHours = workingHours;

    // Check if the user left early
    const department = await Department.findById(user.departmentId);
    if (!department) {
      return res.status(404).json({
        success: false,
        message: "Department not found with this id.",
      });
    }

    if (currentTime < department.expectedCheckOutTime) {
      attendence.isEarlyCheckout = true;
    } else {
      attendence.isEarlyCheckout = false;
    }

    // Save the updated attendance record
    await attendence.save();

    return res.status(200).json({
      success: true,
      message: "Checked out successfully.",
      attendence,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while checking out",
      error: err.message,
    });
  }
};

exports.officeExitRecord = async (req, res) => {
  try {
    const { id } = req.user;

    console.log("this is the id::", id);

    const user = await Employee.findById(id);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "User not found with this id.",
      });
    }

    // console.log("user info:: ", user);

    const today = new Date().toISOString().split("T")[0];

    const attendence = await AttendenceSchema.findOne({
      employee: id,
      date: {
        $gte: new Date(today),
        $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
      },
    });

    console.log("attendance info:: ", attendence);

    if (!attendence) {
      return res.status(404).json({
        success: false,
        message: "No attendance record found for today.",
      });
    }

    const currentTime = new Date();

    const exitTime = currentTime;
    flag = true;
    const returnTime = null;
    const { reason } = req.body;

    const exitRecord = {
      flag,
      exitTime,
      returnTime,
      reason,
    };

    attendence.officeExitRecords.push(exitRecord);

    await attendence.save();

    return res.status(200).json({
      success: true,
      message: "Office exit recorded successfully.",
      attendence: attendence,
      exitRecord: exitRecord,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while recording the exit",
      error: err.message,
    });
  }
};

exports.officeEnterRecord = async (req, res) => {
  try {
    const { id } = req.user;

    // Find the latest attendance record for the employee
    const attendance = await AttendenceSchema.findOne({
      employee: id,
    }).sort({
      date: -1,
    });

    console.log("attendance info::", attendance);

    if (!attendance) {
      return res.status(404).json({
        success: false,
        message: "Attendance record not found.",
      });
    }

    // Find the latest exit record with flag set to true
    const lastExitRecord = attendance.officeExitRecords.find(
      (record) => record.flag == true
    );

    if (!lastExitRecord) {
      return res.status(400).json({
        success: false,
        message: "No active exit record found for the employee.",
      });
    }

    // Update the flag to false and set the return time
    lastExitRecord.flag = false;
    lastExitRecord.returnTime = new Date();

    // Save the updated attendance record
    await attendance.save();

    return res.status(200).json({
      success: true,
      message: "Office entry recorded successfully.",
      attendance,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};
