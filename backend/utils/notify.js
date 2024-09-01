const axios = require("axios");
const getAccessToken = require("./getAccessToken"); // Update this path

async function sendNotification(
  deviceToken,
  title,
  body,
  image = null,
  payload = {}
) {
  const apiPayload = {
    message: {
      token: deviceToken,
      notification: {
        title: title,
        body: body,
        image: image,
      },
      data: payload,
    },
  };

  try {
    const accessToken = await getAccessToken();
    await axios.post(
      "https://fcm.googleapis.com/v1/projects/app-checkpoint/messages:send",
      apiPayload,
      {
        // Replace `your-project-id`
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
      }
    );
    console.log("Notification sent successfully");
  } catch (e) {
    console.error("App notification failed:", e.message);
  }
}

module.exports = sendNotification;
