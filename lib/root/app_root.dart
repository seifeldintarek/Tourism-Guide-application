import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login/login.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Login(),
    );
  }
}
