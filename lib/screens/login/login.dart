import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/screens/signup/signup.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/login/widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        backgroundColor: Default.backgroundColor,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            loginHeader(context, width, height),
            SizedBox(height: height * 0.05),
            labeledTextField(
              label: lang.emailAddress,
              hintText: lang.emailHint,
              controller: _emailController,
              width: width,
              height: height,
            ),
            SizedBox(height: height * 0.025),
            labeledTextField(
              label: lang.password,
              hintText: '••••••••',
              controller: _passwordController,
              obscureText: true,
              width: width,
              height: height,
            ),
            SizedBox(height: height * 0.04),
            continueJourneyButton(
              context,
              width,
              height,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Footer()),
              ),
            ),
            SizedBox(height: height * 0.025),
            Center(
              child: Text(
                lang.forgotPassword,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            SizedBox(height: height * 0.04),
            orDivider(width, height),
            SizedBox(height: height * 0.03),
            socialLoginButtons(context, width, height),
            SizedBox(height: height * 0.04),
            signUpPrompt(
              context,
              width,
              height,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
