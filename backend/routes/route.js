const express = require("express");
const {
  createOffice,
  updateOffice,
  getOfficeDetails,
} = require("../controllers/Office");
const { login, signup } = require("../controllers/Auth");
const router = express.Router();

router.post("/createoffice", createOffice);
router.put("/updateoffice", updateOffice);
router.get("/officedetails", getOfficeDetails);

router.post("/signup", signup);
router.post("/login", login);

module.exports = router;
