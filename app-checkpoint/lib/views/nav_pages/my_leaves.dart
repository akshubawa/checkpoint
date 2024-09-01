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
          SafeArea(
            child: Column(
              children: [
                Text(
                  'My Leaves',
                  style: GoogleFonts.outfit(
                      fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: FittedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: 5 / 20,
                                  strokeWidth: 3,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Colors.blueAccent,
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                ),
                                Text(
                                  '05',
                                  style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Leave Balance',
                          style: GoogleFonts.outfit(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Leaves',
                          style: GoogleFonts.nunitoSans(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '20',
                          style: GoogleFonts.outfit(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Leaves Used',
                          style: GoogleFonts.nunitoSans(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '15',
                          style: GoogleFonts.outfit(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
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
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Text(
            count.toString(),
            style:
                GoogleFonts.outfit(color: color, fontWeight: FontWeight.w600),
          ),
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