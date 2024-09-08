// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

class InHomeWidget extends StatelessWidget {
  const InHomeWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth,
      decoration: BoxDecoration(
          color: const Color(0xff3F81DE).withOpacity(.15),
          shape: BoxShape.circle),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xff3F81DE),
              Color(0xFF9282DF),
            ],
            stops: [0.38, .75],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9282DF).withOpacity(.75),
              blurRadius: 8,
              offset: const Offset(-3, 7),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                UIconsPro.regularRounded.tap,
                color: Colors.white,
                size: screenWidth * .25,
              ),
              Text(
                "CHECK IN",
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