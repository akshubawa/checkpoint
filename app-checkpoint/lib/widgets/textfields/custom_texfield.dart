import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final void Function(String)? onSubmission;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChange;

  const CustomTextfield({
    super.key,
    required this.hint,
    required this.controller,
    this.prefix,
    this.suffix,
    this.onSubmission,
    required this.keyboardType,
    required this.obscureText,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: const TextStyle(
          color: Color.fromRGBO(40, 46, 54, 1),
        ),
        onSubmitted: (value) {
          if (onSubmission != null) {
            onSubmission!(value);
          }
        },
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Ensure background color remains white
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hint,
          hintStyle: GoogleFonts.redHatDisplay(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300, // Lighter border color
            ),
            borderRadius:
                BorderRadius.circular(8.0), // Optional: Add rounded corners
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300, // Lighter border color when enabled
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400, // Slightly darker when focused
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}