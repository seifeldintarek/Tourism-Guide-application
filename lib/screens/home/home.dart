import 'package:flutter/material.dart';
//import 'package:flutter_application_1/screens/profile/manage_profile.dart';
import 'package:flutter_application_1/screens/language/languages.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:flutter_application_1/screens/login/login.dart';//till manage profile is added 
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
 
      // ── Hamburger icon ─────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F4EF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF463427)),
      ),
 
      // ── Drawer ─────────────────────────────────────────────────────────────
      drawer: Drawer(
        backgroundColor: const Color(0xFFF8F4EF),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: const Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF463427),
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
                title: const Text(
                  "Manage Profile",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF463427),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // close drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Infoscreen(),
                    ),
                  );
                },
              ),
 
              // ── Change Language ────────────────────────────────────────────
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: Color(0xFF463427),
                ),
                title: const Text(
                  "Change Language",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF463427),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // close drawer first
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LanguageScreen(),
                    ),
                  );
                },
              ),
 
              const Spacer(),
 
              const Divider(height: 1, color: Color(0xFFD8CFC5)),
 
              // ── Logout ─────────────────────────────────────────────────────
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // close drawer first
                  _showLogoutDialog(context);
                },
              ),
 
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
 
      // ── Body (empty for now) ───────────────────────────────────────────────
      body: const SizedBox.shrink(),
    );
  }
 
  // ── Logout confirmation dialog ─────────────────────────────────────────────
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFF8F4EF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Logout",
          style: TextStyle(
            color: Color(0xFF463427),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(color: Color(0xFF463427)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            ),
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
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
