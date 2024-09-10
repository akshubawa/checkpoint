import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Dateandtime extends StatefulWidget {
  const Dateandtime({super.key});

  @override
  State<Dateandtime> createState() => _DateandtimeState();
}

class _DateandtimeState extends State<Dateandtime> {
  DateTime? checkInTime;
  DateTime? checkOutTime;
  late String? workingHour = "--:--";
  String _timeString = "";
  String _dateString = "";
  Timer? _timer;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _updateTime() {
    setState(() {
      _timeString = _formatTime(DateTime.now());
      _dateString = _formatDate(DateTime.now());
    });
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _formatDate(DateTime date) {
    return "${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}";
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }

  String formatCheckInTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '--:--';
    }
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  void initState() {
    _timeString = _formatTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _timeString,
          style: GoogleFonts.outfit(
            height: 1,
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(73, 84, 99, 1),
          ),
        ),
        Text(
          _dateString,
          style: GoogleFonts.outfit(
            fontSize: 24,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
