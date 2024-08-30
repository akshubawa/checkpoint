import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CheckLocationView extends StatefulWidget {
  const CheckLocationView({super.key});

  @override
  State<CheckLocationView> createState() => _CheckLocationViewState();
}

class _CheckLocationViewState extends State<CheckLocationView> {
  double latitude = 28.449789; // Current location latitude
  double longitude = 77.583860; // Current location longitude

  double targetLatitude = 28.449371;
  double targetLongitude = 77.584114;

  double distanceInMeters = 0.0;
  bool isInRange = false;

  @override
  void initState() {
    calculateDistance(latitude, longitude, targetLatitude, targetLongitude);
    super.initState();
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    calculateDistance(latitude, longitude, targetLatitude, targetLongitude);
  }

  void calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async{
    // String? deviceToken = await FirebaseMessaging.instance.getToken();
    // debugPrint(deviceToken);
    distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude
    );

    // Check if the distance is within 200 meters
    isInRange = distanceInMeters <= 200;

    setState(() {
      // Update the UI with the distance and range status
    });

    debugPrint('Distance: $distanceInMeters meters');
    debugPrint(isInRange ? 'In range' : 'Not in range');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Distance Calculator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Distance to target: ${distanceInMeters.toStringAsFixed(2)} meters'),
            const SizedBox(height: 20),
            Text(
              isInRange ? 'You are in range.' : 'You are not in range.',
              style: TextStyle(
                fontSize: 24,
                color: isInRange ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
