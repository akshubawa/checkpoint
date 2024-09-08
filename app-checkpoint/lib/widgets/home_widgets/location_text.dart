import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

Widget Locationtext({required bool isInRange, required String? cityName}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            UIconsPro.solidRounded.marker,
            color: const Color.fromRGBO(73, 84, 99, 1),
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Text(
                "Location: ",
                style: GoogleFonts.outfit(
                    color: const Color.fromRGBO(73, 84, 99, 1), fontSize: 15),
              ),
              Text(
                (isInRange)
                    ? "You are in Office reach"
                    : "You are not in Office reach",
                style: GoogleFonts.outfit(
                    color: (isInRange) ? Colors.green : Colors.red,
                    // const Color.fromRGBO(
                    //     73, 84, 99, 1),
                    fontSize: 15),
              ),
            ],
          ),
        ],
      ),
      Text(
        cityName ?? "Unable to fetch Location",
        style: GoogleFonts.outfit(
            height: 1,
            color: const Color.fromARGB(255, 136, 148, 166),
            fontSize: 13),
      ),
    ],
  );
}
