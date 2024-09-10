import 'package:flutter/material.dart';

class CustomSnackbar {
  // Function to show the snackbar
  static void show(BuildContext context, String message, String color) {
    // Define the color based on the input
    Color backgroundColor;

    switch (color.toLowerCase()) {
      case 'green':
        backgroundColor = Colors.green;
        break;
      case 'red':
        backgroundColor = Colors.red;
        break;
      case 'yellow':
        backgroundColor = Colors.amber;
        break;
      default:
        backgroundColor = Colors.blueGrey; // default color if none of the above
        break;
    }

    // Create the snackbar
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
