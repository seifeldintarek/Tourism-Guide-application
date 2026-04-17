import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/signup/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Default.Button(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              ),
              child: 'Sign up',
              height: height * 0.08,
              width: width * 0.5,
            ),
            SizedBox(height: 20),
            Default.Button(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Footer()),
              ),
              child: 'Home',
              height: height * 0.08,
              width: width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
