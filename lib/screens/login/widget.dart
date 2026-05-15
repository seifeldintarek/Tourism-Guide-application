import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

// ─── Header Texts ───────────────────────────────────────────────
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 12),
        Center(
          child: Text(
            lang.welcomeBackExplorer,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Labeled TextField ──────────────────────────────────────────
class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 8),
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
}

// ─── Continue Journey Button ────────────────────────────────────
class ContinueJourneyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueJourneyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: height * 0.08,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B2314),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
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
}

// ─── OR CONTINUE WITH Divider ───────────────────────────────────
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.black26)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR CONTINUE WITH',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.5,
              color: Colors.black45,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.black26)),
      ],
    );
  }
}

// ─── Social Login Buttons ───────────────────────────────────────
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.black26),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.apple, color: Colors.black),
            label: const Text(
              'Apple',
              style: TextStyle(color: Colors.black87),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
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
}

// ─── Sign Up Prompt ─────────────────────────────────────────────
class SignUpPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const SignUpPrompt({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
}
