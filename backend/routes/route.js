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
} = require("../controllers/Office");
const {
  createAccount,
  loginAccount,
  updateAccount,
  getUserDetails,
} = require("../controllers/Auth");
const { auth } = require("../middlewares/auth");
const router = express.Router();

const { sendDeviceToken } = require("../controllers/Employee");

router.post("/createoffice", createOffice);
router.put("/updateoffice", updateOffice);
router.get("/officedetails", getOfficeDetails);

router.post("/signup", createAccount);
router.post("/login", loginAccount);
router.post("/update-account", auth, updateAccount);
router.get("/get-account-details", auth, getUserDetails);

router.post("/create-department", createDepartment);
router.post("/update-department", updateDepartment);
router.get("/get-department-details", getDepartmentDetails);

router.post("/checkin", auth, checkIn);
router.post("/checkout", auth, checkOut);

router.post("/send-device-token", sendDeviceToken);

module.exports = router;
