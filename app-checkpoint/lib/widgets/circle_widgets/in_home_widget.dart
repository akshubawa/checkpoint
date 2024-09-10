// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

class InHomeWidget extends StatelessWidget {
  const InHomeWidget({
    super.key,
    required this.screenWidth,
    required this.inRange,
  });

  final double screenWidth;
  final bool inRange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: inRange
          ? () {
              // Add your onTap logic here
            }
          : null,
      child: Container(
        width: screenWidth,
        height: screenWidth,
        decoration: BoxDecoration(
          color: inRange
              ? const Color(0xff3F81DE).withOpacity(.15)
              : Colors.grey.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: inRange
                      ? const LinearGradient(
                          colors: [
                            Color(0xff3F81DE),
                            Color(0xFF9282DF),
                          ],
                          stops: [0.38, .75],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                      : null,
                  boxShadow: inRange
                      ? [
                          BoxShadow(
                            color: const Color(0xFF9282DF).withOpacity(.75),
                            blurRadius: 8,
                            offset: const Offset(-3, 7),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        UIconsPro.regularRounded.tap,
                        color: inRange ? Colors.white : Colors.grey[600],
                        size: screenWidth * .25,
                      ),
                      if (!inRange)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Not in Range",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (inRange)
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
            ),
            // if (!inRange)
            //   Center(
            //     child: Container(
            //       width: screenWidth,
            //       height: screenWidth,
            //       color: Colors.black.withOpacity(0.3),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
