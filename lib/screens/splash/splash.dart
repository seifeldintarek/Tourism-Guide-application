import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/splash/service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startApp();
  }

  void startApp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      initializeApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final AppLocalizations lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),

            Image.asset(
              'assets/images/splash/splash_logo.png',
              width: width * 0.8,
              height: height * 0.4,
              fit: BoxFit.contain,
            ),

            Spacer(),

            Text(
              lang.egypttourismguide,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                color: NudePalette.nudeBrown,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(height: height * 0.06),
          ],
        ),
      ),
    );
  }
}
