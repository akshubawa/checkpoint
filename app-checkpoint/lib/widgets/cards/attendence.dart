import 'dart:convert';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/views/nav_pages/attendance_card.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendence extends StatefulWidget {
  const Attendence({super.key});

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  DateTime selectedDate = DateTime.now();
  final ApiService apiService = ApiService();
  late String token = "";
  bool isLoading = true; // To track the loading state
  late List attendanceRecords = [];

  @override
  void initState() {
    super.initState();
    getTokenFromPrefs();
  }

  void getTokenFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString('token');
    if (storedToken != null) {
      setState(() {
        token = storedToken;
      });
    }
    await getAttendanceData();
  }

  Future<void> getAttendanceData() async {
    try {
      final headers = <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final month = DateFormat('MMMM').format(selectedDate).toLowerCase(); // Get month name
      final year = DateFormat('yyyy').format(selectedDate); // Get year

      final response = await apiService.get(
        'get-all-attendence?month=$month&year=$year',
        headers: headers,
      );
      Map jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['success'] && jsonResponse.containsKey('attendance')) {
        setState(() {
          attendanceRecords = jsonResponse['attendance'];
        });
      } else if (jsonResponse["success"]==false) {
        CustomSnackbar.show(context, "Failed to fetch Attendance. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(context, "Something went wrong. Please try again later.", "red");
      print('Error in API call: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      isLoading = true; // Set loading state
      attendanceRecords = [];
    });
    getAttendanceData(); // Call the API with updated month/year
  }

  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
      isLoading = true; // Set loading state
      attendanceRecords = [];
    });
    getAttendanceData(); // Call the API with updated month/year
  }

  @override
  Widget build(BuildContext context) {
    String monthYear = DateFormat.yMMMM().format(selectedDate);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(screenWidth * .6, screenHeight * 0.25),
            painter: BackgroundPainter0(),
          ),
          Positioned(
            top: screenHeight * 0.5,
            right: -20,
            child: CustomPaint(
              size: Size(screenWidth * .21, screenHeight * 0.13),
              painter: BackgroundPainter1(),
            ),
          ),
          Positioned(
            top: screenHeight * 0.85,
            left: -30,
            child: CustomPaint(
              size: Size(screenWidth * .25, screenHeight * 0.126),
              painter: BackgroundPainter2(),
            ),
          ),
          Positioned(
            top: screenHeight * 0.9,
            right: -10,
            child: CustomPaint(
              size: Size(screenWidth * .5, screenHeight * 0.126),
              painter: BackgroundPainter3(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Text(
                  'Attendance',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _previousMonth,
                        child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue),
                          const SizedBox(width: 8.0),
                          Text(monthYear, style: const TextStyle(color: Colors.blue, fontSize: 16.0)),
                        ],
                      ),
                      GestureDetector(
                        onTap: _nextMonth,
                        child: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('Check-In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('Check-Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('Working Hr\'s', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator()) // Show loader while loading
                      : attendanceRecords.isEmpty
                          ? const Center(child: Text('No Records Available')) // Show 'No Data' if list is empty
                          : ListView.builder(
                              itemCount: attendanceRecords.length,
                              itemBuilder: (context, index) {
                                final record = attendanceRecords[index];
                                return AttendanceCard(record: record);
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
