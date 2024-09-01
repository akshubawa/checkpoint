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
      width: screenWidth * .57,
      height: screenWidth * .57,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color(0xffDE3F81),
            Color(0xFFDF8292),
          ],
          stops: [0.38, .75],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDF8292).withOpacity(.75),
            blurRadius: 8,
            offset: const Offset(-3, 7),
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
    );
  }
}

