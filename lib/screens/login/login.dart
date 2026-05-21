import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/forgot_password/forgot_password.dart';
import 'package:flutter_application_1/screens/signup/signup.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/login/widget.dart';
import 'package:flutter_application_1/screens/login/service.dart';
import 'package:flutter_application_1/screens/language/languages.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

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
    final double hintFontSize = width * 0.031;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        backgroundColor: Default.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF8F4EF),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06,
                  vertical: height * 0.04,
                ),
                child: Text(
                  lang.menu,
                  style: TextStyle(
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF463427),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFD8CFC5)),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: width * 0.06),
                leading: const Icon(Icons.language, color: Color(0xFF463427)),
                title: Text(
                  lang.changeLanguage,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: const Color(0xFF463427),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
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
                validator: (value) => validateEmail(value, lang),
              ),
              SizedBox(height: height * 0.025),
              passwordTextfield(
                _passwordController,
                _obscurePassword,
                () => setState(() => _obscurePassword = !_obscurePassword),
                height,
                width,
                hintFontSize,
                lang.password,
                lang,
              ),
              SizedBox(height: height * 0.04),
              continueJourneyButton(
                context,
                width,
                height,
                onPressed: () async {
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
                              builder: (context) => Footer(user: user),
                            ),
                            (route) => false,
                          );
                  }
                },
              ),
              SizedBox(height: height * 0.025),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPassword()),
                  ),
                  child: Text(
                    lang.forgotPassword,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              orDivider(width, height, lang),
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
              SizedBox(height: height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
