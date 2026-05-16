import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';

Widget labelText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      letterSpacing: 1.2,
      fontWeight: FontWeight.bold,
      color: Color(0xFF4E453E),
    ),
  );
}

Widget passwordTextfield(
  TextEditingController _passwordController,
  String? _passwordError,
  bool _obscurePassword,
  Function setState,
  double height,
  double width,
  double hintFontSize,
) {
  return TextField(
    controller: _passwordController,
    onChanged: (val) => setState(() {}),
    obscureText: _obscurePassword,
    decoration: buildInputDecoration(
      height: height,
      width: width,
      hintFontSize: hintFontSize,
      hint: "Enter your password",
      errorText: _passwordError,
      suffixIcon: IconButton(
        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    ),
  );
}

Widget confirmPasswordTextfield(
  TextEditingController _confirmPasswordController,
  String? _confirmPasswordError,
  bool _obscureConfirmPassword,
  Function setState,
  double height,
  double width,
  double hintFontSize,
) {
  return TextField(
    controller: _confirmPasswordController,
    onChanged: (val) => setState(() {}),
    obscureText: _obscureConfirmPassword,
    decoration: buildInputDecoration(
      height: height,
      width: width,
      hintFontSize: hintFontSize,
      hint: "Confirm your password",
      errorText: _confirmPasswordError,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () =>
            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
      ),
    ),
  );
}

Widget customTextField({
  required TextEditingController controller,
  required String hint,
  bool isPassword = false,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

Widget customDropdown({
  String? value,
  required String hint,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    initialValue: value,
    hint: Text(hint, style: const TextStyle(fontSize: 14)),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    items: items
        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
        .toList(),
    onChanged: onChanged,
  );
}

// ── Reusable local builders ───────────────────────────────────────────────
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

// ── Responsive dropdown (no overflow) ────────────────────────────────────
Widget buildDropdown({
  required String? value,
  required String hint,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  required double width,
  required double hintFontSize,
  required double bodyFontSize,
}) => DropdownButtonHideUnderline(
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
    decoration: BoxDecoration(
      color: const Color(0xFFF2EDE6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: DropdownButton<String>(
      value: value,
      isExpanded: true, // ← key fix: fills width, no overflow
      hint: Text(
        hint,
        style: TextStyle(color: Colors.grey, fontSize: hintFontSize),
        overflow: TextOverflow.ellipsis,
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      style: TextStyle(color: Default.textColor, fontSize: bodyFontSize),
      dropdownColor: const Color(0xFFF2EDE6),
      borderRadius: BorderRadius.circular(12),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: bodyFontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    ),
  ),
);
