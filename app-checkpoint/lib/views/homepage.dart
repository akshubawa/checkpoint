
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final String company = "THECOMPANY";
  final String date = "Wednesday, Dec 12";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Wavy background shape
          CustomPaint(
            size: Size(screenWidth * .6, screenHeight * 0.25),
            painter: WavyBackgroundPainter(),
          ),
          Positioned(
            top: screenHeight * 0.5,
            right: 0,
            child: CustomPaint(
              size: Size(screenWidth * .22, screenHeight * 0.14),
              painter: BackgroundPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          company,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisSize:
                              MainAxisSize.min, // Wraps the content tightly
                          children: [
                            Text(
                              "12:30",
                              style: GoogleFonts.outfit(
                                height: 1,
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(73, 84, 99, 1),
                              ),
                            ),
                            Text(
                              date,
                              style: GoogleFonts.outfit(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          radius: screenWidth * .55,
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * .5)),
                          splashColor:
                              Color.fromARGB(255, 73, 105, 207).withOpacity(.2),
                          splashFactory: InkRipple.splashFactory,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenWidth * .5,
                              height: screenWidth * .5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(
                                        255, 73, 105, 207), // Start color
                                    Color(0xFF9D6EF6), // End color
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.touch_app_rounded,
                                      color: Colors.white,
                                      size: screenWidth * .3,
                                    ),
                                    Text(
                                      "CLOCK IN",
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WavyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    final gradient = LinearGradient(
      colors: [Color(0xffe4e8fb), Color(0xffe8e4ff)],
      stops: [0.2, 0.8],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    // Create a paint object with the gradient
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0026667, size.height * 0.0040000);
    path_0.lineTo(size.width * 0.0053333, size.height * 0.9920000);
    path_0.quadraticBezierTo(size.width * 0.1168333, size.height * 0.8784000,
        size.width * 0.1220000, size.height * 0.7840000);
    path_0.cubicTo(
        size.width * 0.1370000,
        size.height * 0.6394000,
        size.width * 0.1356667,
        size.height * 0.4646000,
        size.width * 0.2646667,
        size.height * 0.2984000);
    path_0.cubicTo(
        size.width * 0.4206667,
        size.height * 0.1720000,
        size.width * 0.6206667,
        size.height * 0.1920000,
        size.width * 0.7446667,
        size.height * 0.1768000);
    path_0.quadraticBezierTo(size.width * 0.8721667, size.height * 0.1620000,
        size.width * 0.9960000, size.height * -0.0040000);

    canvas.drawPath(path_0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    final gradient = LinearGradient(
      colors: [Color(0xffe4e8fb), Color(0xffe8e4ff)],
      stops: [0.2, 0.8],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    // Create a paint object with the gradient
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9880000, 0);
    path_0.quadraticBezierTo(size.width * 0.1750000, size.height * 0.0425000,
        size.width * 0.1120000, size.height * 0.4900000);
    path_0.quadraticBezierTo(size.width * 0.1535000, size.height * 0.9358333,
        size.width * 0.9980000, size.height * 0.9933333);

    canvas.drawPath(path_0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
