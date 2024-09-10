import 'package:checkpoint/views/leaves/leave_request.dart';
import 'package:checkpoint/widgets/background/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLeaves extends StatefulWidget {
  const MyLeaves({super.key});

  @override
  _MyLeavesState createState() => _MyLeavesState();
}

class _MyLeavesState extends State<MyLeaves> {
  bool isApprovalsSelected = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
          // Positioned(
          //   top: screenHeight * 0.1,
          //   bottom: screenHeight * 0.1,
          //   left: screenWidth * .03,
          //   right: screenWidth * .03,
          //   child: Opacity(
          //       opacity: .3, child: SvgPicture.asset("assets/svg/report.svg")),
          // ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'My Leaves',
                    style: GoogleFonts.outfit(
                        color: Color.fromRGBO(51, 60, 72, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenWidth * .57,
                          height: screenWidth * .57,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * .57,
                                height: screenWidth * .57,
                                child: CircularProgressIndicator(
                                  value: 5 / 20,
                                  strokeWidth: 6,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Colors.blueAccent,
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '05',
                                    style: GoogleFonts.outfit(
                                      height: .9,
                                      color: Color.fromRGBO(51, 60, 72, 1),
                                      fontSize: screenWidth * 0.14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Leave Balance',
                                    style: GoogleFonts.outfit(
                                      height: 2,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                      fontSize: screenWidth * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                ModalBottomSheetRoute(
                                    useSafeArea: true,
                                    showDragHandle: true,
                                    builder: (context) => const LeaveRequest(),
                                    isScrollControlled: true));
                          },
                          child: Text(
                            'Click to Apply for Leave',
                            style: GoogleFonts.redHatDisplay(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3.7,
                                backgroundColor: Colors.grey[350],
                              ),
                              const SizedBox(width: 13),
                              Text(
                                'Total Leaves',
                                style: GoogleFonts.outfit(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Text(
                              '20',
                              style: GoogleFonts.outfit(
                                  height: 1,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3.7,
                                backgroundColor: Colors.blue,
                              ),
                              const SizedBox(width: 13),
                              Text(
                                'Leaves Used',
                                style: GoogleFonts.outfit(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            '15',
                            style: GoogleFonts.outfit(
                                height: 1,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    leaveCategory('Casual', 2, Colors.blue),
                    leaveCategory('Medical', 4, Colors.pink),
                    leaveCategory('Annual', 7, Colors.orange),
                    leaveCategory('Maternity', 0, Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isApprovalsSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        backgroundColor: isApprovalsSelected
                            ? Colors.blueAccent
                            : Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Approvals',
                        style: GoogleFonts.redHatDisplay(
                          color:
                              isApprovalsSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isApprovalsSelected = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        backgroundColor: isApprovalsSelected
                            ? Colors.grey.shade200
                            : Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Leaves History',
                        style: GoogleFonts.redHatDisplay(
                          color:
                              isApprovalsSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: isApprovalsSelected
                          ? [
                              leaveRequest('Casual Leave', '25th Mar to 26 Mar',
                                  'REQUESTED'),
                              leaveRequest(
                                  'Casual Leave', '02th Mar', 'APPROVED'),
                            ]
                          : [
                              leaveRequest(
                                  'Medical Leave', '15th Feb', 'APPROVED'),
                              leaveRequest('Annual Leave',
                                  '10th Jan to 12th Jan', 'REJECTED'),
                            ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveCategory(String title, int count, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              color: color,
              value: count.toDouble() / 10,
              strokeWidth: 2.5,
              backgroundColor: Colors.grey[300],
            ),
            Text(
              count.toString(),
              style:
                  GoogleFonts.outfit(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(title,
            style: GoogleFonts.redHatDisplay(
                fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget leaveRequest(String title, String date, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent.withOpacity(0.2),
            radius: 5,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '$title ',
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: 'Applied from $date',
                        style: GoogleFonts.redHatDisplay(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Text(
                  '10th Mar - 2:40 PM',
                  style: GoogleFonts.redHatDisplay(
                      color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          statusBadge(status),
        ],
      ),
    );
  }

  Widget statusBadge(String status) {
    Color color;
    if (status == 'APPROVED') {
      color = Colors.green;
    } else if (status == 'REQUESTED') {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.redHatDisplay(color: color),
      ),
    );
  }
}
