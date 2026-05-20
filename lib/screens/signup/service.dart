import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:provider/provider.dart';

Future<bool> storeUser(final userData, BuildContext context) async {
  UserCredential? userCredential;

  try {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userData["email"].toString().trim(),
      password: userData["password"].toString().trim(),
    );
  } catch (e) {
    print("Error creating Firebase Auth user: $e");
    return false;
  }

  final uid = userCredential.user!.uid;
  final hashedPass = hashPassword(userData["password"]);

  try {
    final locale = context.read<LocaleProvider>().locale;

    DateTime now = DateTime.now();

    final doc = FirebaseFirestore.instance.collection("users").doc(uid);
    await doc.set({
      "id": uid,
      "firstName": userData["firstName"],
      "lastName": userData["lastName"],
      "fullName": "${userData["firstName"]} ${userData["lastName"]}",
      "email": userData["email"],
      "password": hashedPass,
      "language": locale.toString().trim(),
      "joinedAt": now,
      "profilePictureUrl": "",
      "city": userData["city"],
    });

    final appUser = AppUser(
      id: uid,
      firstName: userData["firstName"],
      lastName: userData["lastName"],
      email: userData["email"],
      language: locale.toString().trim(),
      hashedPassword: hashedPass,
      fullName: "${userData["firstName"]} ${userData["lastName"]}",
      joinedAt: now,
      profilePictureUrl: "",
      city: userData["city"],
    );
    await appUser.saveToCache();

    print("User stored and cached successfully.");
    return true;
  } catch (e) {
    print("Error storing user data in Firestore: $e");
    await userCredential.user!.delete();
    return false;
  }
}

String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}
