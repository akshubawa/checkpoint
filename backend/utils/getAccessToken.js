const { JWT } = require("google-auth-library");

// Function to get access token
async function getAccessToken() {
  try {
    // Load the service account key file
    const serviceAccountKey = require("../app-checkpoint-firebase-adminsdk-migey-00bfd8f74f.json"); // Update this path to where your key.json is located

    // Create a new JWT client
    const jwtClient = new JWT({
      email: serviceAccountKey.client_email,
      key: serviceAccountKey.private_key,
      scopes: ["https://www.googleapis.com/auth/cloud-platform"], // Modify scopes if needed
    });

    // Generate an access token
    const accessToken = await jwtClient.getAccessToken();
    return accessToken.token; // Make sure to return the token string
  } catch (error) {
    console.error("Error:", error.message);
    throw error; // Rethrow to handle errors in calling functions
  }
}

module.exports = getAccessToken;
