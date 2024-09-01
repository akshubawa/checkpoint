const admin = require("firebase-admin");
const serviceAccount = require("../app-checkpoint-firebase-adminsdk-migey-748c10ff69.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const sendNotification = async (registrationToken, title, body) => {
  // // Find the employee by ID and get the deviceToken
  // const employee = await Employee.findById(employeeId);

  // if (!employee || !employee.deviceToken) {
  //   throw new Error("Employee not found or device token is missing.");
  // }

  // const registrationToken = employee.deviceInfo.deviceToken;

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
