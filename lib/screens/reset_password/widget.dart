import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';

Widget buildLabel(String text, double labelFontSize) => Text(
  text,
  style: TextStyle(
    fontSize: labelFontSize,
    fontWeight: FontWeight.w600,
    color: Default.textColor,
    letterSpacing: 0.5,
  ),
);

InputDecoration buildInputDecoration({
  required String hint,
  String? errorText,
  Widget? suffixIcon,
  required double width,
  required double height,
  required double hintFontSize,
}) => InputDecoration(
  filled: true,
  fillColor: const Color(0xFFF2EDE6),
  hintText: hint,
  hintStyle: TextStyle(color: Colors.grey, fontSize: hintFontSize),
  errorText: errorText,
  errorStyle: TextStyle(fontSize: hintFontSize * 0.9),
  suffixIcon: suffixIcon,
  contentPadding: EdgeInsets.symmetric(
    horizontal: width * 0.04,
    vertical: height * 0.018,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);

Widget passwordTextField({
  required TextEditingController controller,
  required String hint,
  required String? errorText,
  required bool obscurePassword,
  required VoidCallback onToggle,
  required double height,
  required double width,
  required double hintFontSize,
}) {
  return TextField(
    controller: controller,
    obscureText: obscurePassword,
    decoration: buildInputDecoration(
      height: height,
      width: width,
      hintFontSize: hintFontSize,
      hint: hint,
      errorText: errorText,
      suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: onToggle,
      ),
    ),
  );
}
