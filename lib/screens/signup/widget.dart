import 'package:flutter/material.dart';

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
