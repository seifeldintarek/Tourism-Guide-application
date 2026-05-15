import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

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
      // Utilizing height for relative spacing
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
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      // Utilizing height for relative spacing
      SizedBox(height: height * 0.01),
      TextField(
        controller: controller,
        obscureText: obscureText,
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
        // Utilizing width for relative padding
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
            style: const TextStyle(color: Colors.black87),
          ),
          style: OutlinedButton.styleFrom(
            // Utilizing height for relative padding
            padding: EdgeInsets.symmetric(vertical: height * 0.018),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: Colors.black26),
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
