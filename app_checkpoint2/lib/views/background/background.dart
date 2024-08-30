import 'package:flutter/material.dart';

class BackgroundPainter0 extends CustomPainter {
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

class BackgroundPainter1 extends CustomPainter {
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
