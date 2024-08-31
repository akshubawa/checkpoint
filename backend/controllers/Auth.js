const Employee = require("../models/employee.models");
const Department = require("../models/department.models");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

exports.createAccount = async (req, res) => {
  try {
    const {
      email,
      password,
      departmentName,
      role,
      firstName,
      lastName,
      middleName,
      deviceInfo,
    } = req.body;

    if (
      !email ||
      !password ||
      !departmentName ||
      !role ||
      !firstName ||
      !lastName ||
      !deviceInfo
    ) {
      return res.status(400).json({
        success: false,
        message: "Please enter all the fields.",
      });
    }

    // Find the department by name instead of ID
    const department = await Department.findOne({ name: departmentName });

    if (!department) {
      return res.status(404).json({
        success: false,
        message: "No department found with this name.",
      });
    }

    const isEmailExist = await Employee.findOne({ email });

    if (isEmailExist) {
      return res.status(400).json({
        success: false,
        message: "Email already exists.",
      });
    }

    const departmentId = department._id; // Get the department ID from the found department

    const lastEmployee = await Employee.find({ departmentId })
      .sort({ createdAt: -1 })
      .limit(1);

    let employeeNumber = 1;
    if (lastEmployee.length > 0 && lastEmployee[0].employeeId) {
      const lastEmployeeNumber = parseInt(
        lastEmployee[0].employeeId.split("-").pop(),
        10
      );
      if (!isNaN(lastEmployeeNumber)) {
        employeeNumber = lastEmployeeNumber + 1;
      }
    }

    const employeeId = `${departmentName}-${employeeNumber}`;

    const hashedPassword = await bcrypt.hash(password, 10);

    // Create new employee
    const newEmployee = new Employee({
      firstName,
      middleName,
      lastName,
      email,
      password: hashedPassword,
      departmentName,
      departmentId: department._id,
      role,
      employeeId,
      deviceInfo,
    });

    // Save the new employee
    await newEmployee.save();

    // Generate the token after the employee is saved to get the _id
    const token = jwt.sign(
      {
        id: newEmployee._id, // Set the id here
        email: email,
        role: role,
        department: departmentId,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "7d",
      }
    );

    // Update the employee with the generated token
    newEmployee.token = token;
    await newEmployee.save();

    // Add the new employee to the department's allUser array
    department.allUser.push(newEmployee._id);

    // Save the updated department to the database
    await department.save();

    // Respond with success
    return res.status(200).json({
      success: true,
      message: "Account created successfully.",
      employee: newEmployee,
      token: token,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};

exports.loginAccount = async (req, res) => {
  try {
    const { identifier, password, deviceInfo } = req.body;

    // console.log("identifier",identifier);
    // console.log("password", password);
    // console.log("platform", deviceInfo);
    // cons;

    if (!identifier || !password || !deviceInfo) {
      return res.status(400).json({
        success: false,
        message: "Please enter all required fields.",
      });
    }

    // if (!identifier || !password) {
    //   return res.status(400).json({
    //     success: false,
    //     message: "Please enter both identifier and password.",
    //   });
    // }

    // Find user by either email or employeeId
    const user = await Employee.findOne({
      $or: [{ email: identifier }, { employeeId: identifier }],
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found. Please check your credentials.",
      });
    }

    // Check if the password is correct
    const isPasswordCorrect = await bcrypt.compare(password, user.password);

    if (!isPasswordCorrect) {
      return res.status(401).json({
        success: false,
        message: "Incorrect password.",
      });
    }

    // Generate a new JWT token
    const token = jwt.sign(
      {
        id: user._id,
        email: user.email,
        role: user.role,
        department: user.departmentId,
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "7d",
      }
    );

    // Respond with the token and user data
    return res.status(200).json({
      success: true,
      message: "Login successful.",
      token: token,
      user: {
        id: user._id,
        email: user.email,
        employeeId: user.employeeId,
        role: user.role,
        deviceInfo: deviceInfo,
        departmentId: user.departmentId,
      },
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};

exports.updateAccount = async (req, res) => {
  try {
    const { id } = req.user; // Assuming userId is passed as a URL parameter
    const {
      firstName,
      middleName,
      lastName,
      email,
      password,
      departmentId,
      deviceInfo,
    } = req.body;

    // Find the employee by userId
    // console.log("this is the id", id);
    let user = await Employee.findById(id);
    // console.log("this is the user", user);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found.",
      });
    }

    // Store the old departmentId for potential removal later
    const oldDepartmentId = user.departmentId;

    // Update fields if they are provided in the request body
    if (firstName) user.firstName = firstName;
    if (middleName) user.middleName = middleName;
    if (lastName) user.lastName = lastName;
    if (email) user.email = email;

    // Check if departmentId is being updated and is different from the current one
    if (departmentId && user.departmentId.toString() !== departmentId) {
      const department = await Department.findById(departmentId);
      if (!department) {
        return res.status(404).json({
          success: false,
          message: "Department not found.",
        });
      }
      user.departmentId = departmentId;

      // Add user to the new department's allUser array
      department.allUser.push(user._id);
      await department.save();
    }

    // If a new password is provided, hash it
    if (password) {
      const hashedPassword = await bcrypt.hash(password, 10);
      user.password = hashedPassword;
    }

    // Save the updated user information
    await user.save();

    // Remove user from the old department's allUser array if departmentId was updated
    if (departmentId && oldDepartmentId.toString() !== departmentId) {
      const oldDepartment = await Department.findById(oldDepartmentId);
      if (oldDepartment) {
        oldDepartment.allUser = oldDepartment.allUser.filter(
          (id) => id.toString() !== user._id.toString()
        );
        await oldDepartment.save();
      }
    }

    return res.status(200).json({
      success: true,
      message: "Account updated successfully.",
      user: {
        id: user._id,
        firstName: user.firstName,
        middleName: user.middleName,
        lastName: user.lastName,
        email: user.email,
        departmentId: user.departmentId,
        role: user.role,
      },
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};

exports.getUserDetails = async (req, res) => {
  try {
    const { id } = req.user;

    console.log("this is the id", id);
    const user = await Employee.findById(id).populate("departmentId").exec();

    if (!user) {
      return res.status(500).json({
        success: false,
        message: "User not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "User found",
      user: user,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: err.message,
    });
  }
};
