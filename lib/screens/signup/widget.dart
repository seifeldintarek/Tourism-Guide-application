import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<bool> storeUser(final userData, BuildContext context) async {
  UserCredential? userCredential;

  try {
    // Auth gets the PLAIN password — it handles its own hashing internally
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
    final doc = FirebaseFirestore.instance.collection("users").doc(uid);
    await doc.set({
      "id": uid,
      "firstName": userData["firstName"],
      "lastName": userData["lastName"],
      "fullName": "${userData["firstName"]} ${userData["lastName"]}",
      "email": userData["email"],
      "password": hashedPass, // hashed copy for your own records
      "language": userData["language"],
      "JoinedAt": DateTime.now(),
      "pp": "",
    });

    print("User data stored successfully.");
    return true;
  } catch (e) {
    print("Error storing user data in Firestore: $e");

    // Roll back: delete the Auth account so the user can try again
    await userCredential.user!.delete();

    return false;
  }
}

String hashPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);

  return hash.toString();
}

Widget labelText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 11,
      letterSpacing: 1.2,
      fontWeight: FontWeight.bold,
      color: Color(0xFF4E453E),
    ),
  );
}

Widget customTextField({
  required TextEditingController controller,
  required String hint,
  bool isPassword = false,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

Widget customDropdown({
  String? value,
  required String hint,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    initialValue: value,
    hint: Text(hint, style: const TextStyle(fontSize: 14)),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    items: items
        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
        .toList(),
    onChanged: onChanged,
  );
}
