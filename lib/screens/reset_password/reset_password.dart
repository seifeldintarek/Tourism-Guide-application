import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/reset_password/service.dart';
import 'package:flutter_application_1/screens/reset_password/widget.dart';
import 'package:flutter_application_1/screens/signup/service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.user});

  final AppUser user;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSaving = false;

  String? _oldPasswordError;
  String? _passwordError;
  String? _confirmPasswordError;

  late AppUser _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validate(AppLocalizations lang) {
    bool valid = true;
    String? oldErr;
    String? pwdErr;
    String? confirmErr;

    final oldPassword = _oldPasswordController.text;
    final pwd = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (oldPassword.isEmpty) {
      oldErr = lang.enterPassword;
      valid = false;
    } else if (hashPassword(oldPassword) != _currentUser.hashedPassword) {
      oldErr = 'Type your current password correctly to change it';
      valid = false;
    }

    if (pwd.isEmpty) {
      pwdErr = lang.enterPassword;
      valid = false;
    } else {
      final hasUpper = RegExp(r'[A-Z]').hasMatch(pwd);
      final hasLower = RegExp(r'[a-z]').hasMatch(pwd);
      final hasDigit = RegExp(r'[0-9]').hasMatch(pwd);
      final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(pwd);

      if (pwd.length < 8) {
        pwdErr = lang.password8charserror;
        valid = false;
      } else if (!hasUpper) {
        pwdErr = lang.passwordcapitalerror;
        valid = false;
      } else if (!hasLower) {
        pwdErr = lang.passwordsmallerror;
        valid = false;
      } else if (!hasDigit) {
        pwdErr = lang.passwordnumbererror;
        valid = false;
      } else if (!hasSpecial) {
        pwdErr = lang.passwordspecialcharerror;
        valid = false;
      }
    }

    if (confirm.isEmpty) {
      confirmErr = lang.enterPassword;
      valid = false;
    } else if (pwd != confirm) {
      confirmErr = 'Passwords do not match';
      valid = false;
    }

    setState(() {
      _oldPasswordError = oldErr;
      _passwordError = pwdErr;
      _confirmPasswordError = confirmErr;
    });

    return valid;
  }

  Future<void> _save() async {
    final lang = AppLocalizations.of(context)!;
    if (!_validate(lang)) return;

    setState(() => _isSaving = true);

    try {
      final newHashedPassword = hashPassword(_passwordController.text);
      final updated = await updateUserPassword(
        newHashedPassword: newHashedPassword,
        user: _currentUser,
        context: context,
      );

      if (updated != null) {
        _currentUser = updated;
        _oldPasswordController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      }

      if (mounted) {
        Default.appMsg(context, 'Password updated successfully.');
        Navigator.pop(context, _currentUser);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
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
            SizedBox(height: height * 0.05),

            buildLabel(lang.currentpassword, width * 0.03),
            SizedBox(height: height * 0.01),
            passwordTextField(
              controller: _oldPasswordController,
              hint: lang.currentpassword,
              errorText: _oldPasswordError,
              obscurePassword: _obscureOldPassword,
              onToggle: () =>
                  setState(() => _obscureOldPassword = !_obscureOldPassword),
              height: height,
              width: width,
              hintFontSize: width * 0.028,
            ),
            SizedBox(height: height * 0.03),

            buildLabel(lang.newpassword, width * 0.03),
            SizedBox(height: height * 0.01),
            passwordTextField(
              controller: _passwordController,
              hint: lang.newpassword,
              errorText: _passwordError,
              obscurePassword: _obscurePassword,
              onToggle: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              height: height,
              width: width,
              hintFontSize: width * 0.028,
            ),
            SizedBox(height: height * 0.03),

            buildLabel(lang.confirmPassword, width * 0.03),
            SizedBox(height: height * 0.01),
            passwordTextField(
              controller: _confirmPasswordController,
              hint: lang.confirmPassword,
              errorText: _confirmPasswordError,
              obscurePassword: _obscureConfirmPassword,
              onToggle: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
              height: height,
              width: width,
              hintFontSize: width * 0.028,
            ),
            SizedBox(height: height * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isSaving)
                  SizedBox(
                    width: height * 0.03,
                    height: height * 0.03,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Default.Button(
                    child: lang.saveChanges,
                    onPressed: _save,
                    width: width * 0.23,
                    height: height * 0.06,
                  ),
                SizedBox(width: width * .04),
                Default.Button(
                  buttonColor: Colors.white,
                  textColor: Default.buttonColor,
                  child: lang.cancel,
                  onPressed: () => Navigator.pop(context),
                  width: width * 0.35,
                  height: height * 0.06,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
