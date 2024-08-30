import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

class HomePage extends StatelessWidget {
  final String company = "THECOMPANY";
  final String date = "Wednesday, Dec 12";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
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
            Positioned(
              top: screenHeight * 0.85,
              left: -30,
              child: CustomPaint(
                size: Size(screenWidth * .25, screenHeight * 0.126),
                painter: BackgroundPainter2(),
              ),
            ),
            Positioned(
              top: screenHeight * 0.9,
              right: -10,
              child: CustomPaint(
                size: Size(screenWidth * .5, screenHeight * 0.126),
                painter: BackgroundPainter3(),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          company,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
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
                        Stack(
                          children: [
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.15,
                                child: Image.asset(
                                  "assets/images/map.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {},
                                radius: screenWidth * .55,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(screenWidth * .5)),
                                splashColor: Color.fromARGB(255, 73, 105, 207)
                                    .withOpacity(.2),
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
                                          Color(0xff3F81DE), // Start color
                                          Color(0xFF9282DF), // End color
                                        ],
                                        stops: [0.38, .75],
                                        begin: Alignment.topRight,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            UIconsPro.regularRounded.tap,
                                            color: Colors.white,
                                            size: screenWidth * .25,
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
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Flexible(
                          child: Center(
                              child: Column(
                            children: [
                              Icon(
                                UIconsPro.regularRounded.clock,
                              ),
                              Text(
                                "09:00",
                                style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Clock in",
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
                              Icon(
                                UIconsPro.regularRounded.clock,
                              ),
                              Text(
                                "09:00",
                                style: GoogleFonts.outfit(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Clock Out",
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
                              Icon(
                                UIconsPro.regularRounded.clock,
                              ),
                              Text(
                                "09:00",
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    final gradient = LinearGradient(
      colors: [
        Color(0xffE6F0FE),
        Color.fromARGB(255, 221, 221, 254),
        Color.fromARGB(255, 223, 218, 255)
      ],
      stops: [0.1, 0.6, 0.7],
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
      colors: [
        Color(0xffE6F0FE),
        Color.fromARGB(255, 221, 221, 254),
        Color.fromARGB(255, 223, 218, 255)
      ],
      stops: [0.15, 0.4, 0.5],
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

class BackgroundPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    final gradient = LinearGradient(
      colors: [
        Color(0xffE6F0FE),
        Color.fromARGB(255, 221, 221, 254),
        Color.fromARGB(255, 223, 218, 255)
      ],
      stops: [0.15, 0.4, 0.5],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    // Create a paint object with the gradient
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0156000, size.height * 0.1574000);
    path_0.lineTo(size.width * 0.2372000, size.height * 1.0105000);
    path_0.quadraticBezierTo(size.width * 1.0499763, size.height * 0.8024316,
        size.width * 0.9809459, size.height * 0.1337724);
    path_0.quadraticBezierTo(size.width * 0.8997157, size.height * -0.1201242,
        size.width * 0.0156000, size.height * 0.1574000);
    path_0.close();
    canvas.drawPath(path_0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BackgroundPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a gradient
    final gradient = LinearGradient(
      colors: [
        Color(0xffE6F0FE),
        Color.fromARGB(255, 221, 221, 254),
        Color.fromARGB(255, 223, 218, 255)
      ],
      stops: [0.15, 0.4, 0.5],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    // Create a paint object with the gradient
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0107692, size.height * 0.9800000);
    path_0.quadraticBezierTo(size.width * 0.7607692, size.height * 0.9875000,
        size.width * 1.0107692, size.height * 0.9900000);
    path_0.quadraticBezierTo(size.width * 1.2934615, size.height * -0.0680000,
        size.width * 1.0184615, size.height * 0.0540000);
    path_0.cubicTo(
        size.width * 0.5142308,
        size.height * 0.2175000,
        size.width * 0.7603846,
        size.height * 0.3695000,
        size.width * 0.0107692,
        size.height * 0.9800000);
    path_0.close();

    canvas.drawPath(path_0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}