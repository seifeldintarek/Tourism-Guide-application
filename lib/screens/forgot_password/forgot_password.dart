import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/forgot_password/service.dart';
import 'package:flutter_application_1/screens/forgot_password/widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _emailController;

  bool _isSending = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validate(AppLocalizations lang) {
    final email = _emailController.text.trim();
    String? error;

    if (email.isEmpty) {
      error = lang.emailHint;
    } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email)) {
      error = lang.invalidEmailFormat;
    }

    setState(() => _emailError = error);
    return error == null;
  }

  Future<void> _sendResetEmail() async {
    final lang = AppLocalizations.of(context)!;
    if (!_validate(lang)) return;

    setState(() => _isSending = true);

    try {
      final success = await sendForgotPasswordEmail(
        email: _emailController.text.trim(),
        context: context,
      );

      if (!mounted) return;

      if (success) {
        Default.appMsg(context, lang.passresetemailsent);
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        backgroundColor: Default.backgroundColor,
        elevation: 0,
        title: Text(
          lang.forgotPassword.replaceAll('?', ''),
          style: TextStyle(
            color: Default.textColor,
            fontFamily: 'Times New Roman',
            fontSize: width * 0.052,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: ListView(
          children: [
            SizedBox(height: height * 0.08),
            Text(
              lang.forgotPassword.replaceAll('?', ''),
              style: TextStyle(
                color: Default.textColor,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
                fontSize: width * 0.075,
              ),
            ),
            SizedBox(height: height * 0.015),
            Text(
              lang.forgetpassemailhint,
              style: TextStyle(
                color: Default.textColor.withOpacity(0.75),
                fontSize: width * 0.035,
                height: 1.4,
              ),
            ),
            SizedBox(height: height * 0.05),
            buildLabel(lang.emailAddress, width * 0.03),
            SizedBox(height: height * 0.01),
            emailTextField(
              controller: _emailController,
              hint: lang.emailHint,
              errorText: _emailError,
              height: height,
              width: width,
              hintFontSize: width * 0.028,
            ),
            SizedBox(height: height * 0.05),
            if (_isSending)
              Center(
                child: SizedBox(
                  width: height * 0.035,
                  height: height * 0.035,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              Default.Button(
                child: lang.forgotPassword.replaceAll('?', ''),
                onPressed: _sendResetEmail,
                width: width * 0.8,
                height: height * 0.06,
              ),
            SizedBox(height: height * 0.02),
            Default.Button(
              buttonColor: Colors.white,
              textColor: Default.buttonColor,
              child: lang.cancel,
              onPressed: () => Navigator.pop(context),
              width: width * 0.8,
              height: height * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}
