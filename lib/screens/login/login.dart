import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/signup/signup.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/login/widget.dart';
import 'package:flutter_application_1/screens/login/service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Added FormKey to manage validation state
  final _formKey = GlobalKey<FormState>();

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
        // Wrapped the Column in a Form widget
        child: Form(
          key: _formKey,
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
                validator: validateEmail, // Calling the extracted function
              ),
              SizedBox(height: height * 0.025),
              passwordTextfield(
                _passwordController,
                _obscurePassword,
                () => setState(() => _obscurePassword = !_obscurePassword),
                height,
                width,
                width * 0.031,
                lang.password,
              ),
              // labeledTextField(
              //   label: lang.password,
              //   hintText: '••••••••',
              //   controller: _passwordController,
              //   obscureText: true,
              //   width: width,
              //   height: height,
              //   validator: validatePassword, // Calling the extracted function
              // ),
              SizedBox(height: height * 0.04),
              continueJourneyButton(
                context,
                width,
                height,
                onPressed: () async {
                  // Trigger form validation
                  if (_formKey.currentState!.validate()) {
                    AppUser? user = await loginUser(
                      context: context,
                      lang: lang,
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    user == null
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(lang.invalidcreds)),
                          )
                        : Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Footer(user: user!),
                            ),
                            (route) => false,
                          );
                  }
                },
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
      ),
    );
  }
}
