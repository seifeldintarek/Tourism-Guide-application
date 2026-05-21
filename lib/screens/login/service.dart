import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/signup/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    if (context.mounted) {
      context.read<LocaleProvider>().setLocale(
        Locale(user.language.toLowerCase()),
      );
    }

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

Future<AppUser?> signInWithGoogle(BuildContext context) async {
  try {
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final User? firebaseUser = userCredential.user;
    if (firebaseUser == null) return null;

    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid);

    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      final user = AppUser.fromMap(doc.data()!);

      if (context.mounted) {
        context.read<LocaleProvider>().setLocale(
          Locale(user.language.toLowerCase()),
        );
      }

      return user;
    }

    final displayName = firebaseUser.displayName ?? "";
    final nameParts = displayName.trim().split(" ");
    final firstName = nameParts.isNotEmpty ? nameParts.first : "";
    final lastName = nameParts.length > 1 ? nameParts.last : "";

    final newUser = AppUser(
      id: firebaseUser.uid,
      firstName: firstName,
      lastName: lastName,
      fullName: displayName,
      email: firebaseUser.email ?? "",
      city: "Cairo",
      language: "en",
      hashedPassword: "",
      joinedAt: DateTime.now(),
      profilePictureUrl: firebaseUser.photoURL,
    );

    await docRef.set(newUser.toMap());

    if (context.mounted) {
      context.read<LocaleProvider>().setLocale(const Locale("en"));
    }

    return newUser;
  } catch (e) {
    print("Google Sign-In Error: $e");
    return null;
  }
}
