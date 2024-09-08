import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget Bottominfo(
    {required String checkin,
    required String checkout,
    required String? workingHour}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          Flexible(
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  "assets/images/checkin.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  checkin,
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Check in",
                  style: GoogleFonts.outfit(
                    height: 1,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
          ),
          Flexible(
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  "assets/images/checkout.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  checkout,
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Check Out",
                  style: GoogleFonts.outfit(
                    height: 1,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
          ),
          Flexible(
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  "assets/images/clockcheck.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  workingHour ?? "--:--",
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Working Hr's",
                  style: GoogleFonts.outfit(
                    height: 1,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    ],
  );
}
