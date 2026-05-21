import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/edit_profile/edit_profile.dart';
import 'package:flutter_application_1/screens/language/languages.dart';
import 'package:flutter_application_1/screens/settings/widget.dart';
import 'package:flutter_application_1/screens/reset_password/reset_password.dart'; //till manage profile is added

class Hamburger extends StatefulWidget {
  Hamburger({super.key, required this.user});
  AppUser user;
  @override
  State<Hamburger> createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: const Color(0xFFF8F4EF),
      child: SafeArea(
        child: Column(
          children: [
            // Header
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

            // ── Manage Profile ─────────────────────────────────────────────
            ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Color(0xFF463427),
              ),
              title: Text(
                lang.manageProfile,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color(0xFF463427),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfile(user: widget.user),
                  ),
                );
              },
            ),

            // ── Change Language ────────────────────────────────────────────
            ListTile(
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
                Navigator.pop(context); // close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LanguageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_reset, color: Color(0xFF463427)),
              title: Text(
                lang.resetpassword,
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
                  MaterialPageRoute(
                    builder: (_) => ResetPassword(user: widget.user),
                  ),
                );
              },
            ),
            const Spacer(),

            const Divider(height: 1, color: Color(0xFFD8CFC5)),

            // ── Logout ─────────────────────────────────────────────────────
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                lang.logout,
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // close drawer first
                showLogoutDialog(context);
              },
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
