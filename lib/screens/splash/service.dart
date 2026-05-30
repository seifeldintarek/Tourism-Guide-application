import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

Future<void> initializeApp(BuildContext context) async {
  final navigator = Navigator.of(context);
  final localeProvider = context.read<LocaleProvider>();

  void goToLogin() {
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    await AppUser.clearCache();
    if (!context.mounted) return;
    goToLogin();
    return;
  }

  AppUser? appUser;

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    appUser = AppUser.fromMap(doc.data()!);
    await appUser.saveToCache();
  } catch (e) {
    debugPrint('Firestore fetch failed, trying cache: $e');
    appUser = await AppUser.loadFromCache();
  }

  if (!context.mounted) return;

  final loadedUser = appUser;
  if (loadedUser == null) {
    goToLogin();
    return;
  }

  localeProvider.setLocale(Locale(loadedUser.language.toLowerCase()));

  navigator.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => Footer(user: loadedUser)),
    (route) => false,
  );
}