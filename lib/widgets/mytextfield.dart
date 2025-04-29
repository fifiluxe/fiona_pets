import 'package:flutter/material.dart';

Widget myTextField({
  String? hintText,
  required TextEditingController controller,
  Color? fillColor,
  Color? textColor,
  Color? hintTextColor,
  bool obscureText = false,
  TextInputType? keyboardType, // Optional keyboard type
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType, // Apply the keyboard type
    style: TextStyle(color: textColor), // Controls input text color
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: fillColor ?? Colors.transparent,
      filled: fillColor != null, // Enable fill color only if provided
      hintStyle: TextStyle(color: hintTextColor), // Controls hint text color
      prefixIcon: const Icon(Icons.person),
      border: const OutlineInputBorder(borderSide: BorderSide()),
    ),
  );
}
