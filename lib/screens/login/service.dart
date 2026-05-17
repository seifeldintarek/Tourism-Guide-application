import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/signup/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<AppUser?> loginUser({
  required BuildContext context,
  required AppLocalizations lang,
  required String email,
  required String password,
}) async {
  try {
    final hashedPass = hashPassword(password.trim());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: hashedPass,
    );

    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    AppUser user = AppUser.fromMap(doc.data()!);

    context.read<LocaleProvider>().setLocale(
      Locale(user.language.toLowerCase()),
    );

    return user;
  } on FirebaseAuthException catch (e) {
    print("Auth Error: ${e.code}");
    return null;
  } catch (e) {
    print("Login Error: $e");
    Default.appMsg(context, lang.invalidcreds.toString());
    return null;
  }
}
