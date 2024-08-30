import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String company = "THE COMPANY";
  final String date = "Wednesday, Dec 12";

  bool _isFlipped = false;
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Ripple effect that repeats 3 times
    _waveAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 150),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 0),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 150),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 0),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 150),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 150, end: 0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

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
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    company,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "12:30",
                        style: GoogleFonts.outfit(
                          height: 1,
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(73, 84, 99, 1),
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
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _waveController,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            painter: WaveCirclePainter(_waveAnimation.value),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isFlipped = !_isFlipped;
                              });
                              _waveController.forward(from: 0);
                            },
                            borderRadius: BorderRadius.circular(screenWidth * .5),
                            splashColor: const Color.fromARGB(255, 73, 105, 207)
                                .withOpacity(.2),
                            splashFactory: InkRipple.splashFactory,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: screenWidth * .5,
                              height: screenWidth * .5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isFlipped
                                    ? const Color(0xFF008000)
                                    : const Color(0xff3F81DE),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _isFlipped
                                            ? Icons.work_history_rounded
                                            : Icons.home,
                                        color: Colors.white,
                                        size: screenWidth * .25,
                                      ),
                                      Text(
                                        _isFlipped ? "IN OFFICE" : "IN HOME",
                                        style: GoogleFonts.nunitoSans(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveCirclePainter extends CustomPainter {
  final double radius;

  WaveCirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3F81DE).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
