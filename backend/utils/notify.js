const admin = require("firebase-admin");
const serviceAccount = require("../app-checkpoint-firebase-adminsdk-migey-748c10ff69.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const registrationToken =
  "c_jSiI3sAEl5gd3Mreog2r:APA91bEXF0mSTN6ezvcXDA8k_c4uFktxMo6zLbQWa45ke7n2OhsenJ1kgOIEYmf-ppGNE6ZrHjYmlOfd2mLpTtgnp1OHvQkmbDqstrXpYsn0W_pwBv0RpZGG2Ohd8aDNmiLckPTdVTqm";

const sendNotification = async (title, body) => {
  const messageSend = {
    token: registrationToken,
    notification: {
      title: title,
      body: body,
    },
    // data: {
    //   key1: "value1",
    //   key2: "value2",
    // },
    // android: {
    //   priority: "high",
    // },
    // apns: {
    //   payload: {
    //     aps: {
    //       badge: 42,
    //     },
    //   },
    // },
  };

  admin
    .messaging()
    .send(messageSend)
    .then((response) => {
      console.log("Successfully sent message:", response);
    })
    .catch((error) => {
      console.log("Error in sending message:", error);
    });
};

module.exports = {
  sendNotification,
};
