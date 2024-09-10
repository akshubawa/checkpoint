import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.record,
    required this.screenWidth,
  });

  final Map<String, dynamic> record;
  final double screenWidth;

  String formatToIST(String? timeString) {
    if (timeString == null || timeString.isEmpty) {
      return 'N/A';
    }
    DateTime utcTime = DateTime.parse(timeString);
    tz.Location india = tz.getLocation('Asia/Kolkata');
    tz.TZDateTime istTime = tz.TZDateTime.from(utcTime, india);
    return DateFormat('hh:mm a').format(istTime);
  }

  @override
  Widget build(BuildContext context) {
    // Ensure timezone data is initialized
    tz.initializeTimeZones();

    // Parse the date and format it
    DateTime date = DateTime.parse(record["date"]);
    String formattedDate = DateFormat('dd').format(date);
    String day = DateFormat('EEE').format(date).toUpperCase();

    // Format the check-in and check-out times to IST
    String clockIn = formatToIST(record["checkInTime"]);
    String clockOut = formatToIST(record["checkOutTime"]);

    // Calculate the total working hours
    double totalWorkingHours = record["totalWorkingHours"] ?? 0.0;
    String hours = "${totalWorkingHours.toStringAsFixed(2)} hrs";

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * .03, vertical: screenWidth * .01),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        formattedDate,
                        style: GoogleFonts.outfit(
                            color: Color.fromRGBO(51, 60, 72, 1),
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      day,
                      style: GoogleFonts.redHatDisplay(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .025),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: -45 * pi / 180,
                      child: Icon(UIconsPro.regularRounded.arrow_small_right,
                          color: Colors.blue, size: 18),
                    ),
                    Text(clockIn,
                        style: GoogleFonts.outfit(color: Colors.green)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .035),
                child: Row(
                  children: [
                    Icon(UIconsPro.regularRounded.arrow_small_down,
                        color: Colors.yellow.shade700, size: 18),
                    Text(clockOut,
                        style: GoogleFonts.outfit(color: Colors.red)),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * .1),
                child:
                    Text(hours, style: GoogleFonts.outfit(color: Colors.blue)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 72.0),
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 0,
          ),
        ),
      ],
    );
  }
}
