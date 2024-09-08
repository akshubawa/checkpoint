# Checkpoint: Geolocation-Based Attendance Tracking Mobile Application

## Project Overview

Checkpoint is a mobile application developed by Team Tech Fusion for the SIH hackathon. It aims to streamline and automate attendance tracking for employees across multiple office locations using geolocation technology and face recognition for enhanced security.

### Key Features

1. **Geolocation-Based Check-In and Check-Out**
   - Automatic recording of check-in time and location within a 200-meter radius of the office
   - Automatic check-out when leaving the 200-meter radius
   - Pairing of check-ins with corresponding check-outs

2. **Face Recognition for Enhanced Security**
   - Users must submit a live selfie for check-in
   - Face recognition processing to verify user identity
   - Option for users to upload photos for face training
   - Admin can also upload photos for face training

3. **Manual Location Check-In / Check-Out for Offsite Work**
   - Manual check-in and check-out feature for employees working offsite
   - Suggestion of relevant locations based on real-time longitude and latitude data

4. **Working Hours Calculation**
   - Automatic calculation of total working hours for employees
   - Display of total check-in time

5. **Data Accuracy and Integrity**
   - Maintenance of accurate and tamper-proof records
   - Real-time data synchronization and secure storage

## How It Works

1. **User Authentication**: Users start by logging in or signing up for the app.

2. **Location Verification**: The check-in button is only activated when the user is present at their designated work location.

3. **Face Recognition Check-In**: 
   - When a user attempts to check in, they must submit a live selfie.
   - The app processes the selfie using face recognition to verify the user's identity.
   - This adds an extra layer of security to prevent location spoofing.

4. **Automatic Check-Out**: The app automatically checks out the user when they leave the designated work location.

5. **Working Hours Tracking**: The app displays the total check-in time for the user.

6. **Face Recognition Training**: 
   - Users can upload their photos within the app for face recognition training.
   - Admins also have the option to upload photos for face recognition training.

## Repository Structure

- `adminpanel/`: Contains files for the admin panel interface
- `web-checkpoint/`: Web version of the Checkpoint application
- `app-checkpoint/`: Flutter application files (compatible with Android and iOS)
- `backend/`: Backend files including models and routes

## Setup Instructions

1. Clone the repository:
   ```
   git clone https://github.com/akshubawa/checkpoint.git
   ```

2. Set up the backend:
   - Navigate to the `backend` folder
   - Install dependencies: `npm install`
   - Configure your database connection
   - Start the server: `npm start`

3. Set up the Flutter app:
   - Navigate to the `app-checkpoint` folder
   - Install Flutter dependencies: `flutter pub get`
   - Run the app: `flutter run`

4. Set up the admin panel:
   - Navigate to the `adminpanel` folder
   - Follow the setup instructions in the folder's README

## Team Tech Fusion

We are a team of six members participating in the SIH hackathon. Our goal is to create an efficient and user-friendly attendance tracking solution using geolocation technology and face recognition for enhanced security.

## Note

This project uses free and open-source resources as per the hackathon guidelines. No hardware, software, licenses, data, or other resources are provided by GAIL (INDIA) LTD.

## For More Information

For a detailed explanation of the problem statement, please refer to this [YouTube video](https://youtu.be/bmw8unoxA7U).
