// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InOfficeWidget extends StatelessWidget {
  const InOfficeWidget({
    super.key,
    required String formattedCounter,
    required this.screenWidth,
  }) : _formattedCounter = formattedCounter;

  final String _formattedCounter;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth,
      decoration: BoxDecoration(
          color: const Color(0xff3F81DE).withOpacity(.1),
          shape: BoxShape.circle),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(133, 43, 135, 1),
              Color.fromRGBO(255, 82, 70, 0.522)
            ],
            stops: [0.17, 0.89],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(244, 67, 54, 1).withOpacity(.75),
              blurRadius: 8,
              offset: const Offset(3, 7),
            ),
          ],
        ),
        child: Transform.flip(
          flipX: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formattedCounter,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * .10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "CHECK OUT",
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
