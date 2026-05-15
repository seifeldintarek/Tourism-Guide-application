import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/splash_logo.png',
      width: 220,
      height: 220,
      fit: BoxFit.contain,
    );
  }
}
