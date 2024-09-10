const Employee = require("../models/employee.models");
const Office = require("../models/office.models");
const Department = require("../models/department.models");
const AttendenceSchema = require("../models/attendence.models");
const OffsiteWork = require("../models/offsite.work.model");
const OffSideWorkSchema = require("../models/offsideLocations.models");
const LeaveRequest = require("../models/leaveRequest.models");
const sendNotification = require("../utils/notify");
const getAccessToken = require('../utils/getAccessToken');

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

exports.createOffsideLocation = async (req, res) => {
  try {
    const { officeName, name, coordinates } = req.body;

    if (
      !officeName ||
      !name ||
      !coordinates.latitude ||
      !coordinates.longitude
    ) {
      return res.status(400).json({
        success: false,
        message: "Please enter all the fields.",
      });
    }

    const office = await Office.findOne({ name: officeName });

    if (!office) {
      return res.status(500).json({
        success: false,
        message: "No office found with this name.",
      });
    }

    const offsiteLocation = await OffSideWorkSchema.findOne({
      name,
    });

    if (offsiteLocation) {
      return res.status(400).json({
        success: false,
        message: "Offsite location already exists.",
      });
    }

    const newOffSiteLocation = new OffSideWorkSchema({
      officeId: office._id,
      officeName: officeName,
      name,
      coordinates: {
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
      },
    });

    await newOffSiteLocation.save();

    office.allOffsideLocations.push(newOffSiteLocation._id);

    await office.save();

    return res.status(200).json({
      success: true,
      message: "Offsite location created successfully.",
      offsiteLocation: newOffSiteLocation,
      office: office.allOffsideLocations,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occured while creating the offsite location",
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

      const department = await Department.findById(user.departmentId);
      if (!department) {
        return res.status(403).json({
          success: false,
          message: "Department not found with this id.",
        });
      }

      const currentTime = new Date();
      const newAttendence = new AttendenceSchema({
        employee: id,
        checkInTime: currentTime,
        checkOutTime: null,
        isLateCheckIn: currentTime > department.expectedCheckInTime,
      });

      await newAttendence.save();
      user.isActive = true;
      user.allAttendence.push(newAttendence._id);
      await user.save();

      const registrationToken = user.deviceInfo.deviceToken;

      await sendNotification(
        deviceToken = registrationToken,
        "Check-in",
        "You have successfully checked in.",
        null,
        {},
      );

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

  // Check-Out Function
  exports.checkOut = async (req, res) => {
    try {
      const { id } = req.user;
      const user = await Employee.findById(id);
      if (!user) {
        return res.status(403).json({
          success: false,
          message: "User not found with this id.",
        });
      }

      const today = new Date().toISOString().split("T")[0];
      const lastAttendance = await AttendenceSchema.findOne({
        employee: id,
        date: {
          $gte: new Date(today),
          $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
        },
      }).sort({ checkInTime: -1 });

      if (!lastAttendance) {
        return res.status(404).json({
          success: false,
          message: "No attendance record found for today.",
        });
      }

      const currentTime = new Date();
      lastAttendance.checkOutTime = currentTime;
      lastAttendance.totalWorkingHours = (currentTime - new Date(lastAttendance.checkInTime)) / (1000 * 60 * 60);

      const department = await Department.findById(user.departmentId);
      if (!department) {
        return res.status(404).json({
          success: false,
          message: "Department not found with this id.",
        });
      }

      lastAttendance.isEarlyCheckout = currentTime < department.expectedCheckOutTime;

      user.isActive = false;
      await user.save();
      await lastAttendance.save();

      const registrationToken = user.deviceInfo.deviceToken;

      await sendNotification(
        deviceToken = registrationToken,
        "Check-out",
        "You have successfully checked out.",
        null,
        {}
      );

      return res.status(200).json({
        success: true,
        message: "Checked out successfully.",
        attendence: lastAttendance,
      });
    } catch (err) {
      return res.status(500).json({
        success: false,
        message: "Error occurred while checking out",
        error: err.message,
      });
    }
  };

exports.applyHalfDayLeave = async (req, res) => {
  try {
    const { id } = req.user;
    const { reason } = req.body;

    const user = await Employee.findById(id);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "User not found with this ID.",
      });
    }

    const today = new Date().toISOString().split("T")[0];

    const attendance = await AttendenceSchema.findOne({
      employee: id,
      date: {
        $gte: new Date(today),
        $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
      },
    });

    if (!attendance) {
      return res.status(404).json({
        success: false,
        message: "No attendance record found for today.",
      });
    }

    const currentTime = new Date();

    // Create a leave request for admin approval
    const leaveRequest = new LeaveRequest({
      employee: id,
      attendance: attendance._id,
      exitTime: currentTime,
      returnTime: null,
      reason: reason,
      isApprovedByAdmin: false,
    });

    await leaveRequest.save();

    return res.status(200).json({
      success: true,
      message:
        "Half-day leave request submitted successfully. Waiting for admin approval.",
      leaveRequest,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while applying for half-day leave.",
      error: err.message,
    });
  }
};

exports.approveLeaveRequest = async (req, res) => {
  try {
    const { requestId, approve } = req.body;

    // Find the leave request by ID
    const leaveRequest = await LeaveRequest.findById(requestId).populate(
      "attendance"
    );

    if (!leaveRequest) {
      return res.status(404).json({
        success: false,
        message: "Leave request not found.",
      });
    }

    if (!leaveRequest.attendance) {
      return res.status(404).json({
        success: false,
        message: "Attendance record not found.",
      });
    }

    // Approve or reject the leave request
    leaveRequest.isApprovedByAdmin = approve;

    if (approve) {
      // Modify the attendance document (e.g., mark it as a leave or update the times)
      leaveRequest.attendance.isOnLeave = true; // Example field, adjust as per your schema
      leaveRequest.attendance.checkOutTime = leaveRequest.exitTime; // Assuming the exitTime is used as checkOutTime
      leaveRequest.attendance.checkInTime = leaveRequest.returnTime; // Assuming returnTime is the check-in time after leave

      // Save the attendance document
      await leaveRequest.attendance.save();
    }

    // Save the leave request document
    await leaveRequest.save();

    return res.status(200).json({
      success: true,
      message: "Leave request processed successfully.",
      leaveRequest,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while processing leave request.",
      error: err.message,
    });
  }
};

exports.getPendingLeaveRequests = async (req, res) => {
  try {
    const pendingRequests = await LeaveRequest.find({
      isApprovedByAdmin: false,
    })
      .populate("employee", "name email")
      .populate("attendance", "date");

    if (pendingRequests.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No pending leave requests found.",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Pending leave requests fetched successfully.",
      pendingRequests,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Error occurred while fetching pending leave requests.",
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

exports.getAllAttendance = async (req, res) => {
  try {
    const userId = req.user.id;
    let { month, year } = req.query;

    console.log("This is the user ID:", userId);

    const user = await Employee.findById(userId);

    if (!user) {
      return res.status(403).json({
        success: false,
        message: "User not found, user ID is not valid.",
      });
    }

    const monthNames = {
      january: 0,
      february: 1,
      march: 2,
      april: 3,
      may: 4,
      june: 5,
      july: 6,
      august: 7,
      september: 8,
      october: 9,
      november: 10,
      december: 11,
    };

    month = month.toLowerCase();
    const monthIndex = monthNames[month];
    const yearNumber = parseInt(year, 10);

    if (monthIndex === undefined || isNaN(yearNumber)) {
      return res.status(400).json({
        success: false,
        message: "Invalid month or year provided.",
      });
    }

    const startDate = new Date(yearNumber, monthIndex, 1);
    const endDate = new Date(yearNumber, monthIndex + 1, 1);

    const attendance = await AttendenceSchema.find({
      employee: userId,
      date: {
        $gte: startDate,
        $lt: endDate,
      },
    });

    if (attendance.length === 0) {
      return res.status(404).json({
        success: true,
        message: "No attendance record found for the specified month and year.",
      });
    }

    // Filter to get the most recent record per day
    const recentAttendance = attendance.reduce((acc, record) => {
      const recordDate = new Date(record.date).toDateString();
      if (
        !acc[recordDate] ||
        new Date(record.date) > new Date(acc[recordDate].date)
      ) {
        acc[recordDate] = record;
      }
      return acc;
    }, {});

    // Convert the object to an array
    const filteredAttendance = Object.values(recentAttendance);

    return res.status(200).json({
      success: true,
      message: "Attendance records found.",
      attendance: filteredAttendance,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error.",
      error: err.message,
    });
  }
};

exports.offSiteWorkRequest = async (req, res) => {
  try {
    const { id } = req.user;

    const user = await Employee.findById(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    const { type, reason } = req.body;

    const date = new Date();

    const newOffSiteWork = new OffsiteWork({
      employee: id,
      date,
      type,
      reason,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};

exports.getCheckinCheckoutStatus = async (req, res) => {
  try {
    const { id } = req.user;

    // Find the user
    const user = await Employee.findById(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    // Get today's date in YYYY-MM-DD format
    const today = new Date().toISOString().split("T")[0];

    // Find all attendance records for today
    const attendances = await AttendenceSchema.find({
      employee: id,
      date: {
        $gte: new Date(today),
        $lt: new Date(new Date(today).setDate(new Date(today).getDate() + 1)),
      },
    });

    // If no attendance record found for today
    if (attendances.length === 0) {
      return res.status(404).json({
        success: true,
        message: "No attendance record found for today.",
      });
    }

    // Get the last attendance record for today
    const lastAttendance = attendances[attendances.length - 1];

    return res.status(200).json({
      success: true,
      message: "Check-in and check-out status retrieved successfully.",
      checkInTime: lastAttendance.checkInTime,
      checkOutTime: lastAttendance.checkOutTime,
      totalWorkingHours: lastAttendance.totalWorkingHours,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};
