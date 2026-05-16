import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/navigationbar.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

Future<void> initializeApp(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    await AppUser.clearCache();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
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
    print("Firestore fetch failed, trying cache: $e");

    appUser = await AppUser.loadFromCache();
  }

  if (appUser == null) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
    return;
  }

  context.read<LocaleProvider>().setLocale(
    Locale(appUser.language.toLowerCase()),
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Footer(user: appUser!)),
    (route) => false,
  );
}
