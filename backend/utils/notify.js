const axios = require("axios");
const {JWT} = require('google-auth-library');

async function getAccessToken() {
    try{
        const serviceAccountKey = require('../app-checkpoint-firebase-adminsdk-migey-f9f14c84c5.json');

        const jwtClient = new JWT({
            email: serviceAccountKey.client_email,
            key: serviceAccountKey.private_key,
            scopes: ["https://www.googleapis.com/auth/cloud-platform"],
        });

        const accessToken = await jwtClient.getAccessToken();
        console.log("this is the access token ::::: ", accessToken.token);
        return accessToken.token;
    }catch(error){
        console.log("Error: ", error.message);
    }
}

async function sendNotification(
  deviceToken,
  title,
  body,
  image = null,
  payload = {},
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
    await axios.post(
      "https://fcm.googleapis.com/v1/projects/app-checkpoint/messages:send",
      apiPayload,
      {
        headers: {
          Authorization: "Bearer "+(await getAccessToken()),
          "Content-Type": "application/json",
        },
      }
    );
    // console.log("this is the accessToken............................................",accessToken);
    console.log("Notification sent successfully");
  } catch (e) {
    console.error("App notification failed:", e.message);
    // console.log("this is the error ", e);
  }
}

module.exports = sendNotification;
