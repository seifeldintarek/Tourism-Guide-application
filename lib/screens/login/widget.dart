import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/core/default.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(value)) {
    return "Invalid email format";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  final hasUpper = RegExp(r'[A-Z]').hasMatch(value);
  final hasLower = RegExp(r'[a-z]').hasMatch(value);
  final hasDigit = RegExp(r'[0-9]').hasMatch(value);
  final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(value);

  if (value.length < 8) {
    return "Password must be at least 8 characters";
  } else if (!hasUpper) {
    return "Add at least one capital letter";
  } else if (!hasLower) {
    return "Add at least one small letter";
  } else if (!hasDigit) {
    return "Add at least one number";
  } else if (!hasSpecial) {
    return "Add at least one special character";
  }

  return null;
}

Widget loginHeader(BuildContext context, double width, double height) {
  final lang = AppLocalizations.of(context)!;
  return Column(
    children: [
      Center(
        child: Text(
          lang.signInToYourJournal,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 2,
            color: Colors.black54,
          ),
        ),
      ),
      SizedBox(height: height * 0.015),
      Center(
        child: Text(
          lang.welcomeBackExplorer,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

Widget labeledTextField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false,
  required double width,
  required double height,
  String? Function(String?)? validator, // Accept validator
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      SizedBox(height: height * 0.01),
      TextFormField(
        // Changed to TextFormField for validation support
        controller: controller,
        obscureText: obscureText,
        validator: validator, // Apply validator
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          filled: true,
          fillColor: const Color(0xFFEDE4D8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget continueJourneyButton(
  BuildContext context,
  double width,
  double height, {
  required VoidCallback onPressed,
}) {
  final lang = AppLocalizations.of(context)!;
  return SizedBox(
    width: width,
    height: height * 0.08,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B2314),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: Text(
        lang.continueJourney,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget orDivider(double width, double height) {
  return Row(
    children: [
      const Expanded(child: Divider(color: Colors.black26)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: const Text(
          'OR CONTINUE WITH',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.5,
            color: Colors.black45,
          ),
        ),
      ),
      const Expanded(child: Divider(color: Colors.black26)),
    ],
  );
}

Widget socialLoginButtons(BuildContext context, double width, double height) {
  final lang = AppLocalizations.of(context)!;
  return Row(
    children: [
      Expanded(
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: Image.network(
            'https://www.google.com/favicon.ico',
            width: 20,
            height: 20,
          ),
          label: Text(
            lang.signInWithGoogle,
            style: TextStyle(color: Default.textColor),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    ],
  );
}

Widget signUpPrompt(
  BuildContext context,
  double width,
  double height, {
  required VoidCallback onTap,
}) {
  final lang = AppLocalizations.of(context)!;
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: '${lang.newHere}  ',
          style: const TextStyle(color: Colors.black54, fontSize: 14),
          children: [
            TextSpan(
              text: lang.createAnAccount,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
