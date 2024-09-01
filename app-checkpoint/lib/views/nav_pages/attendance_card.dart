import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.record,
  });

  final Map<String, dynamic> record;

  @override
  Widget build(BuildContext context) {
    // Parse the date and format it
    DateTime date = DateTime.parse(record["date"]);
    String formattedDate = DateFormat('dd').format(date);
   String day = DateFormat('EEE').format(date).toUpperCase();
 // Get the day of the week

    // Format the check-in and check-out times
    String clockIn = DateFormat('hh:mm a').format(DateTime.parse(record["checkInTime"]));
    String clockOut = DateFormat('hh:mm a').format(DateTime.parse(record["checkOutTime"]));

    // Calculate the total working hours
    double totalWorkingHours = record["totalWorkingHours"];
    String hours = "${totalWorkingHours.toStringAsFixed(2)} hrs";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      day,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.arrow_outward_rounded, color: Colors.blue, size: 18),
                  const SizedBox(width: 4),
                  Text(clockIn, style: const TextStyle(color: Colors.green)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.arrow_downward, color: Colors.yellow.shade700, size: 18),
                  const SizedBox(width: 4),
                  Text(clockOut, style: const TextStyle(color: Colors.red)),
                ],
              ),
              Text(hours, style: const TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 72.0), // Adjust this value to control the left padding
          child: Divider(
            color: Colors.grey.shade300, // Light grey color for the divider
            thickness: 1, // Thickness of the divider
            height: 0, // Height to minimize extra space
          ),
        ),
      ],
    );
  }
}
