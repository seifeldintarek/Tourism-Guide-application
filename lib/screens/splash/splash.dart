import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(),

            SplashLogo(),

            Spacer(),

            Text(
              'Egypt Tourism Guide',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                color: NudePalette.nudeBrown,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
