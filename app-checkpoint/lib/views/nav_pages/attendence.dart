import 'dart:convert';

import 'package:checkpoint/api/api_service.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/cards/attendance_card.dart';
import 'package:checkpoint/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
import 'package:uicons_pro/uicons_pro.dart';

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

      final month = DateFormat('MMMM')
          .format(selectedDate)
          .toLowerCase(); // Get month name
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
      } else if (jsonResponse["success"] == false) {
        CustomSnackbar.show(context,
            "Failed to fetch Attendance. Please try again later.", "red");
      }
    } catch (e) {
      CustomSnackbar.show(
          context, "Something went wrong. Please try again later.", "red");
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
      backgroundColor: Colors.white,
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
          Positioned(
            top: screenHeight * 0.25,
            bottom: screenHeight * 0.25,
            left: screenWidth * .05,
            right: screenWidth * .05,
            child: Opacity(
                opacity: .3,
                child: SvgPicture.asset("assets/svg/attendance.svg")),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Attendance',
                      style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromRGBO(51, 60, 72, 1)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[350]!)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _previousMonth,
                            child: const Icon(Icons.arrow_back_ios,
                                color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(UIconsPro.regularRounded.calendar,
                                  color: Colors.blue),
                              const SizedBox(width: 8.0),
                              Text(monthYear,
                                  style: GoogleFonts.redHatDisplay(
                                      color: Colors.blue, fontSize: 16.0)),
                            ],
                          ),
                          GestureDetector(
                            onTap: _nextMonth,
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date',
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text('Check-In',
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text('Check-Out',
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Text('Working Hr\'s',
                            style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator()) // Show loader while loading
                        : attendanceRecords.isEmpty
                            ? Center(
                                child: Text(
                                'No Records Available',
                                style: GoogleFonts.redHatDisplay(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600),
                              )) // Show 'No Data' if list is empty
                            : ListView.builder(
                                itemCount: attendanceRecords.length,
                                itemBuilder: (context, index) {
                                  final record = attendanceRecords[index];
                                  return AttendanceCard(
                                    record: record,
                                    screenWidth: screenWidth,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}