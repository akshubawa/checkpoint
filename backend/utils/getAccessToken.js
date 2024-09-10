const { JWT } = require("google-auth-library");

// Function to get access token
async function getAccessToken() {
  try {
    // Load the service account key file
    const serviceAccountKey = require("../app-checkpoint-firebase-adminsdk-migey-00bfd8f74f.json");

    // Create a new JWT client
    const jwtClient = new JWT({
      email: serviceAccountKey.client_email,
      key: serviceAccountKey.private_key,
      scopes: ["https://www.googleapis.com/auth/cloud-platform"], // Modify scopes if needed
    });

    // Generate an access token
    console.log("inside the getAccessToken function before")
    const accessToken = await jwtClient.getAccessToken();
    console.log("inside the getAccessToken function after")
    return accessToken; // Make sure to return the token string
    // console.log()
  } catch (error) {
    console.error("Error:", error.message);
    throw error; // Rethrow to handle errors in calling functions
  }
}

module.exports = getAccessToken;
