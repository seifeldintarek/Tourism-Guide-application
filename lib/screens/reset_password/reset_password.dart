import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/reset_password/service.dart';
import 'package:flutter_application_1/screens/reset_password/widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.user});

  final AppUser user;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // ── direct-change controllers ──────────────────────────────────────────────

  // ── email-reset controller ─────────────────────────────────────────────────
  final TextEditingController _emailController = TextEditingController();

  bool _isSendingEmail = false;

  String? _emailError;

  // 0 = "I know my password", 1 = "Send reset email"
  int _selectedTab = 0;

  late AppUser _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    // Pre-fill email field for convenience
    _emailController.text = _currentUser.email ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ── send reset email ──────────────────────────────────────────────────────

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(
        () => _emailError = AppLocalizations.of(context)!.invalidEmailFormat,
      );
      return;
    }

    // Very basic email format guard
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      setState(() => _emailError = AppLocalizations.of(context)!.emailHint);
      return;
    }

    setState(() {
      _emailError = null;
      _isSendingEmail = true;
    });

    try {
      await sendPasswordResetEmail(email: email, context: context);
      // Success message is shown inside the service function.
      // Optionally pop back after a short delay so the user can read the snackbar.
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSendingEmail = false);
    }
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        title: Text(
          lang.resetpassword,
          style: TextStyle(
            color: Default.textColor,
            fontFamily: 'Times New Roman',
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: ListView(
          children: [
            SizedBox(height: height * 0.04),

            _buildEmailResetBody(width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailResetBody(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter the email address linked to your account. '
          'We will send you a link to reset your password.',
          style: TextStyle(
            fontSize: width * 0.028,
            color: Default.textColor.withOpacity(0.75),
          ),
        ),
        SizedBox(height: height * 0.03),

        buildLabel(AppLocalizations.of(context)!.emailAddress, width * 0.03),
        SizedBox(height: height * 0.01),

        // Plain text field reusing buildInputDecoration from widget.dart
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: buildInputDecoration(
            hint: AppLocalizations.of(context)!.emailHint,
            errorText: _emailError,
            width: width,
            height: height,
            hintFontSize: width * 0.028,
          ),
        ),
        SizedBox(height: height * 0.05),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isSendingEmail)
              SizedBox(
                width: height * 0.03,
                height: height * 0.03,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Default.Button(
                child: AppLocalizations.of(context)!.sendresetemail,
                onPressed: _sendResetEmail,
                width: width * 0.4,
                height: height * 0.06,
              ),
            SizedBox(width: width * .04),
            Default.Button(
              buttonColor: Colors.white,
              textColor: Default.buttonColor,
              child: AppLocalizations.of(context)!.cancel,
              onPressed: () => Navigator.pop(context),
              width: width * 0.35,
              height: height * 0.06,
            ),
          ],
        ),
      ],
    );
  }
}
