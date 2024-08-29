const express = require("express");
const {
  createOffice,
  updateOffice,
  getOfficeDetails,
} = require("../controllers/Office");
const router = express.Router();

router.post("/createoffice", createOffice);
router.put("/updateoffice", updateOffice);
router.get("/officedetails", getOfficeDetails);

module.exports = router;
