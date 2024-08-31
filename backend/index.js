const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const database = require("./config/database");
const router = require("./routes/route");
const { sendNotification } = require("./utils/notify");

const app = express();
app.use(express.json());

dotenv.config();

app.use(cors());

database.connect();

const PORT = process.env.PORT || 4000;

app.use("/api/v1/", router);

// sendNotification("this is the title", "this is the body");

app.get("/", (req, res) => {
  return res.status(200).json({
    success: true,
    message: "your server is up and running......",
  });
});

app.listen(PORT, () => {
  console.log(`your server is running on port ${PORT}`);
});
