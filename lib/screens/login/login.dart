import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EDE3),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        centerTitle: true,
        title: const Text(
          'THE ARCHIVE',
          style: TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const LoginHeader(),
            const SizedBox(height: 40),
            LabeledTextField(
              label: lang.emailAddress,
              hintText: lang.emailHint,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            LabeledTextField(
              label: lang.password,
              hintText: '••••••••',
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ContinueJourneyButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Footer()),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                lang.forgotPassword,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 32),
            const OrDivider(),
            const SizedBox(height: 24),
            const SocialLoginButtons(),
            const SizedBox(height: 32),
            SignUpPrompt(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}