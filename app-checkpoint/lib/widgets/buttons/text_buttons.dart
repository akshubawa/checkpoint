import 'package:flutter/material.dart';

class TextButtonWithGradient extends StatelessWidget {
  final Widget child;
  final double? elevation;
  final void Function(BuildContext) onPressed;
  final Gradient gradient;

  const TextButtonWithGradient({
    required this.onPressed,
    required this.child,
    required this.gradient,
    this.elevation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: elevation,
          splashFactory: InkRipple.splashFactory,
          visualDensity: const VisualDensity(vertical: 2),
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
        ),
        onPressed: () {
          onPressed(context);
        },
        child: child,
      ),
    );
  }
}