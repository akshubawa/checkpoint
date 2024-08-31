import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendence extends StatefulWidget {

  const Attendence({super.key});

  @override
  State<Attendence> createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, String>> attendanceRecords = [
    {"date": "11", "day": "TUE", "clockIn": "09:15am", "clockOut": "05:45pm", "hours": "07h 30m"},
    {"date": "10", "day": "MON","clockIn": "09:25am", "clockOut": "06:25pm", "hours": "08h 00m"},
    {"date": "07", "day": "FRI","clockIn": "09:05am", "clockOut": "06:15pm", "hours": "08h 10m"},
    {"date": "06", "day": "THU","clockIn": "08:55am", "clockOut": "05:05pm", "hours": "07h 15m"},
    {"date": "05", "day": "WED","clockIn": "09:35am", "clockOut": "06:15pm", "hours": "08h 10m"},
    {"date": "04", "day": "TUE","clockIn": "09:05am", "clockOut": "06:15pm", "hours": "08h 10m"},
    {"date": "03", "day": "MON","clockIn": "08:55am", "clockOut": "05:05pm", "hours": "07h 15m"},
    {"date": "01", "day": "SUN","clockIn": "09:35am", "clockOut": "06:15pm", "hours": "07h 30m"},
  ];

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
  }

@override
  Widget build(BuildContext context) {
    String monthYear = DateFormat.yMMMM().format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
          const Divider(), // Optional, for separation between the date selector and the list
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(color: Color(0xFFFBF9FB)),
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
            child: ListView.builder(
              itemCount: attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = attendanceRecords[index];
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
                                  record["date"]!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                                ),
                                Text(
                                  record["day"]!,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.arrow_outward_rounded, color: Colors.blue, size: 18),
                              const SizedBox(width: 4),
                              Text(record["clockIn"] ?? "", style: const TextStyle(color: Colors.green)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_downward, color: Colors.yellow.shade700, size: 18),
                              const SizedBox(width: 4),
                              Text(record["clockOut"] ?? "", style: const TextStyle(color: Colors.red)),
                            ],
                          ),
                          Text(record["hours"] ?? "", style: const TextStyle(color: Colors.blue)),
                          // Icon(Icons.chevron_right, color: Colors.grey.shade400),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}