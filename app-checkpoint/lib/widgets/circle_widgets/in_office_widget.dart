import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InOfficeWidget extends StatefulWidget {
  const InOfficeWidget({
    super.key,
    required String formattedCounter,
    required this.screenWidth,
    required this.onPlayPauseTap,
    required this.isPaused,
    required this.inRange,
  }) : _formattedCounter = formattedCounter;

  final String _formattedCounter;
  final double screenWidth;
  final VoidCallback onPlayPauseTap;
  final bool isPaused;
  final bool inRange;

  @override
  State<InOfficeWidget> createState() => _InOfficeWidgetState();
}

class _InOfficeWidgetState extends State<InOfficeWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Background container
        Container(
          width: widget.screenWidth,
          height: widget.screenWidth,
          decoration: BoxDecoration(
            color: const Color(0xff3F81DE).withOpacity(.1),
            shape: BoxShape.circle,
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(133, 43, 135, 1),
                  Color.fromRGBO(255, 82, 70, 0.522),
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
              flipX: (widget.inRange) ? true : false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget._formattedCounter,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.screenWidth * .10,
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
        ),
        // Play/pause button
        Positioned(
          left: screenWidth / 5,
          bottom: 0,
          child: Container(
            margin: const EdgeInsets.all(0.2),
            padding: const EdgeInsets.all(0.2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF00C853),
                  Color(0xFF00E5FF),
                ],
                stops: [0.2, 0.8],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 6,
                  offset: const Offset(3, 7),
                ),
              ],
            ),
            child: Transform.flip(
              flipX: true,
              child: Center(
                child: IconButton(
                  iconSize: screenWidth * 0.12,
                  icon: Icon(
                    widget.isPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    color: Colors.white,
                  ),
                  onPressed: widget.onPlayPauseTap,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
