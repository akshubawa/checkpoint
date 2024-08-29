const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const database = require("./config/database");
const router = require("./routes/route");

const app = express();
app.use(express.json());

dotenv.config();

app.use(cors());

database.connect();

const PORT = process.env.PORT || 4000;

app.use("/api/v1/", router);

app.get("/", (req, res) => {
  return res.status(200).json({
    success: true,
    message: "your server is up and running......",
  });
});

app.listen(PORT, () => {
  console.log(`your server is running on port ${PORT}`);
});
