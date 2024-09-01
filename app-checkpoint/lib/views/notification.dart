
import 'package:checkpoint/widgets/background/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons_pro/uicons_pro.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String name = "Yash";
    String leaveCause = "Casual leave";
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
              bottom: 0,
              right: 0,
              left: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              UIconsPro.regularRounded.arrow_circle_left,
                            ),
                          ),
                          Text(
                            "Notifications",
                            style: GoogleFonts.outfit(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/images/control.png",
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .02,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            height: screenHeight * 0.1,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.black45),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Icon(UIconsPro.regularRounded.user),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text.rich(TextSpan(children: [
                                            TextSpan(
                                                text: "$name ",
                                                style: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            TextSpan(
                                                text: "Applied for ",
                                                style: GoogleFonts.outfit(
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: "$leaveCause ",
                                                style: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            TextSpan(
                                                text: "for 15 February 2019",
                                                style: GoogleFonts.outfit(
                                                    fontSize: 14)),
                                          ])),
                                        ),
                                        Text(
                                          "12:40 PM",
                                          style: GoogleFonts.outfit(
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    UIconsPro.boldRounded.menu_dots,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}