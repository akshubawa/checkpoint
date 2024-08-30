import 'package:app_checkpoint2/views/background/background.dart';
import 'package:app_checkpoint2/views/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:uicons_pro/uicons_pro.dart';

class HomePage extends StatelessWidget {
  final String company = "THECOMPANY";
  final String date = "Wednesday, Dec 12";

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(screenWidth * .6, screenHeight * 0.25),
              painter: BackgroundPainter0(),
            ),
            Positioned(
              top: screenHeight * 0.5,
              right: -20,
              child: CustomPaint(
                size: Size(screenWidth * .21, screenHeight * 0.13),
                painter: BackgroundPainter1(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          SizedBox(
                            height: screenHeight * .1,
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
                          SizedBox(
                            height: screenHeight * .03,
                          ),
                          Stack(
                            children: [
                              Opacity(
                                opacity: 0.045,
                                child: Image.asset(
                                  "assets/images/map.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {},
                                      radius: screenWidth * .6,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(screenWidth * .5)),
                                      splashColor:
                                          Color.fromARGB(255, 73, 105, 207)
                                              .withOpacity(.2),
                                      splashFactory: InkRipple.splashFactory,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RippleAnimation(
                                          repeat: true,
                                          minRadius: 75,
                                          ripplesCount: 4,
                                          duration:
                                              const Duration(seconds: 4 * 1),
                                          child: Container(
                                            width: screenWidth * .57,
                                            height: screenWidth * .57,
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
                                                  color: Color(0xFF9282DF)
                                                      .withOpacity(.75),
                                                  blurRadius: 8,
                                                  offset: const Offset(-3, 7),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    UIconsPro
                                                        .regularRounded.tap,
                                                    color: Colors.white,
                                                    size: screenWidth * .25,
                                                  ),
                                                  Text(
                                                    "CLOCK IN",
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * .07,
                      ),
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
                                Image.asset(
                                  "assets/images/checkout.png",
                                  width: 30,
                                  height: 30,
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
                                Image.asset(
                                  "assets/images/clockcheck.png",
                                  width: 30,
                                  height: 30,
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
            ),
          ],
        ),
      ),
    );
  }
}
