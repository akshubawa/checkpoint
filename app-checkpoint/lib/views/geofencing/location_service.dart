import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double TARGET_LATITUDE = 28.4488539;
  static const double TARGET_LONGITUDE = 77.5778341;
  static const double RANGE_THRESHOLD = 200.0; // in meters

  late StreamSubscription<Position> _positionStreamSubscription;
  bool _isInRange = false;
  bool _isCheckedIn = false;

  void startTracking(Function(bool) onLocationChanged) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle permission denied
        return;
      }
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        TARGET_LATITUDE,
        TARGET_LONGITUDE,
      );

      bool newIsInRange = distance <= RANGE_THRESHOLD;

      if (newIsInRange != _isInRange) {
        _isInRange = newIsInRange;
        if (_isInRange && !_isCheckedIn) {
          _isCheckedIn = true;
          onLocationChanged(true); // Check-in
        } else if (!_isInRange && _isCheckedIn) {
          _isCheckedIn = false;
          onLocationChanged(false); // Check-out
        }
      }
    });
  }

  void stopTracking() {
    _positionStreamSubscription.cancel();
  }
}