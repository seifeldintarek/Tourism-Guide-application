import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/login/login.dart';

void showLogoutDialog(BuildContext context) {
  final lang = AppLocalizations.of(context)!;
  final width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFFF8F4EF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      title: Text(
        lang.logoutConfirmTitle,
        style: const TextStyle(
          color: Color(0xFF463427),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        lang.logoutConfirmMessage,
        style: const TextStyle(color: Color(0xFF463427)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(lang.cancel, style: const TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(ctx);
            // TODO: clear session / tokens, then navigate to Login
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
          ),
          child: Text(lang.logout, style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
