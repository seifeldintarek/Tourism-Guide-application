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

// ── Text fields ───────────────────────────────────────────────────────────────

/// General-purpose text field.
/// [errorText] is optional — pass it to show an inline validation message.
Widget customTextField({
  required TextEditingController controller,
  required String hint,
  bool isPassword = false,
  String? errorText,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
      errorText: errorText,
      errorStyle: const TextStyle(fontSize: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

/// Password field with show/hide toggle.
Widget passwordTextfield(
  TextEditingController controller,
  String? errorText,
  bool obscurePassword,
  VoidCallback onToggle,
  double height,
  double width,
  double hintFontSize,
) {
  return TextField(
    controller: controller,
    obscureText: obscurePassword,
    decoration: buildInputDecoration(
      height: height,
      width: width,
      hintFontSize: hintFontSize,
      hint: "Enter your password",
      errorText: errorText,
      suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: onToggle,
      ),
    ),
  );
}

/// Confirm-password field with show/hide toggle.
Widget confirmPasswordTextfield(
  TextEditingController controller,
  String? errorText,
  bool obscureConfirmPassword,
  VoidCallback onToggle,
  double height,
  double width,
  double hintFontSize,
) {
  return TextField(
    controller: controller,
    obscureText: obscureConfirmPassword,
    decoration: buildInputDecoration(
      height: height,
      width: width,
      hintFontSize: hintFontSize,
      hint: "Confirm your password",
      errorText: errorText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: onToggle,
      ),
    ),
  );
}

// ── Dropdown ──────────────────────────────────────────────────────────────────

// ── Place card ────────────────────────────────────────────────────────────────

Widget buildPlaceCard({
  required String title,
  required String category,
  required String location,
  required String imageUrl,
  required double screenWidth,
  required double screenHeight,
  VoidCallback? onDelete,
}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
    ),
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.025),
      child: Row(
        children: [
          // Delete icon
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: screenWidth * 0.02),

          // Image thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: Image.network(
              imageUrl,
              width: screenWidth * 0.16,
              height: screenWidth * 0.16,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '$category • $location',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey[600],
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
