const express = require("express");
const {
  createOffice,
  updateOffice,
  getOfficeDetails,
  createDepartment,
  updateDepartment,
  getDepartmentDetails,
  checkIn,
  checkOut,
  getAllDepartments,
  officeEnterRecord,
  officeExitRecord,
  getAllOffices,
  getAllAttendence,
  createOffsideLocation,
} = require("../controllers/Office");
const {
  createAccount,
  loginAccount,
  updateAccount,
  getUserDetails,
} = require("../controllers/Auth");
const { auth } = require("../middlewares/auth");
const router = express.Router();

// hello world

router.post("/createoffice", createOffice);
router.put("/updateoffice", updateOffice);
router.get("/officedetails", getOfficeDetails);
router.get("/get-all-offices", getAllOffices);

router.post("/create-offsite-location", createOffsideLocation);

router.post("/signup", createAccount);
router.post("/login", loginAccount);
router.post("/update-account", auth, updateAccount);
router.get("/get-account-details", auth, getUserDetails);
router.get("/get-all-attendence", auth, getAllAttendence);

router.post("/create-department", createDepartment);
router.post("/update-department", updateDepartment);
router.get("/get-department-details", getDepartmentDetails);
router.get("/get-all-departments", getAllDepartments);

router.post("/checkin", auth, checkIn);
router.post("/checkout", auth, checkOut);
router.post("/office-exit-record", auth, officeExitRecord);
router.post("/office-enter-record", auth, officeEnterRecord);

module.exports = router;
