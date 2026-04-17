import 'package:flutter/material.dart';

class Default {
  // Usage: get width and height of screen
  // double width = MediaQuery.of(context).size.width,
  //     height = MediaQuery.of(context).size.height;

  static final backgroundColor = Colors.white70;
  static final buttonColor = Colors.brown.shade900;

  static Widget Button({
    required void Function()? onPressed,
    required String? child,
    required double width,
    required double height,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(child!, style: TextStyle(color: Colors.white)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}

class NudePalette {
  static const Color nudeLight = Color(0xFFF5E6DA); // very light cream
  static const Color nude = Color(0xFFE8CFC1); // soft beige
  static const Color nudePink = Color(0xFFD8A7A0); // blush pink
  static const Color nudeBrown = Color(0xFFB08968); // warm brown
  static const Color nudeDark = Color(0xFF7F5539); // deep brown
}
