import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:background_locator/location_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static double targetLatitude = 28.450371597622993;
  static double targetLongitude = 77.58493137009076;
  static const double rangeInMeters = 160.0;

  static Future<void> callback(LocationDto? locationDto) async {
    if (locationDto == null) {
      // Handle the case when the callback is triggered from notification tap
      print('Notification tapped');
      return;
    }

    // Rest of your callback logic
    final SendPort? send = IsolateNameServer.lookupPortByName('LocatorIsolate');
    send?.send(locationDto);

    await _handleLocation(locationDto);
  }

  static Future<void> initCallback(Map<String, dynamic> params) async {
    // This is called when the location service is initialized
    print('Background location service initialized');
  }

  static Future<void> disposeCallback() async {
    // This is called when the location service is disposed
    print('Background location service disposed');
  }

  static Future<void> notificationCallback() async {
    // Handle the logic when the notification is tapped
    print('Notification was tapped.');
  }

  static Future<void> _handleLocation(LocationDto locationDto) async {
    double distanceInMeters = Geolocator.distanceBetween(
      locationDto.latitude,
      locationDto.longitude,
      targetLatitude,
      targetLongitude,
    );

    bool isInRange = distanceInMeters <= rangeInMeters;
    bool wasInRange = await _getStoredInRangeStatus();

    if (isInRange != wasInRange) {
      if (isInRange) {
        await _performCheckIn();
      } else {
        await _performCheckOut();
      }
      await _storeInRangeStatus(isInRange);
    }
  }

  static Future<bool> _getStoredInRangeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isInRange') ?? false;
  }

  static Future<void> _storeInRangeStatus(bool isInRange) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isInRange', isInRange);
  }

  static Future<void> _performCheckIn() async {
    await _sendRequest('checkin');
  }

  static Future<void> _performCheckOut() async {
    await _sendRequest('checkout');
  }

  static Future<void> _sendRequest(String action) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT/$action'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('$action successful');
      } else {
        print('$action failed');
      }
    }
  }
}
