import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';

Future<String?> _getAuthUid(BuildContext context) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    Default.appMsg(context, "No authenticated user found.");
    return null;
  }
  return currentUser.uid;
}

Future<AppUser?> _patchUser({
  required AppUser user,
  required Map<String, dynamic> fields,
  required BuildContext context,
  required String errorLabel,
}) async {
  try {
    final uid = await _getAuthUid(context);
    if (uid == null) return null;

    final docRef = FirebaseFirestore.instance.collection("users").doc(user.id);
    await docRef.update(fields);

    // Build the updated user by merging the old map with the new fields.
    final updatedMap = {
      ...user.toMap(),
      ...fields,
      // Preserve the original Timestamp-safe value for JoinedAt.
      "JoinedAt": user.JoinedAt.toIso8601String(),
    };
    final updatedUser = AppUser.fromMap(updatedMap);
    await updatedUser.saveToCache();

    return updatedUser;
  } catch (e) {
    print("Error updating $errorLabel: $e");
    Default.appMsg(context, "Failed to update $errorLabel. Please try again.");
    return null;
  }
}

// ─────────────────────────────────────────────
// Update first name
// ─────────────────────────────────────────────
Future<AppUser?> updateUserFirstName(
  String newFirstName,
  AppUser user,
  BuildContext context,
) async {
  return _patchUser(
    user: user,
    fields: {"firstName": newFirstName},
    context: context,
    errorLabel: "first name",
  );
}

// ─────────────────────────────────────────────
// Update last name
// ─────────────────────────────────────────────
Future<AppUser?> updateUserLastName(
  String newLastName,
  AppUser user,
  BuildContext context,
) async {
  return _patchUser(
    user: user,
    fields: {"lastName": newLastName},
    context: context,
    errorLabel: "last name",
  );
}

// ─────────────────────────────────────────────
// Update full name (first + last together)
// ─────────────────────────────────────────────
Future<AppUser?> updateUserFullName(
  String newFirstName,
  String newLastName,
  AppUser user,
  BuildContext context,
) async {
  final newFullName = "$newFirstName $newLastName".trim();
  return _patchUser(
    user: user,
    fields: {
      "firstName": newFirstName,
      "lastName": newLastName,
      "fullName": newFullName,
    },
    context: context,
    errorLabel: "full name",
  );
}

// ─────────────────────────────────────────────
// Update password (Firebase Auth + Firestore hash)
// ─────────────────────────────────────────────
Future<AppUser?> updateUserPassword(
  String newHashedPassword,
  AppUser user,
  BuildContext context,
) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Default.appMsg(context, "No authenticated user found.");
      return null;
    }

    // Update password on Firebase Auth side as well.
    // Caller is responsible for passing the plain-text password here for Auth,
    // and the hashed version for Firestore storage.
    // If you hash before calling, adjust accordingly.
    await currentUser.updatePassword(newHashedPassword);

    return _patchUser(
      user: user,
      fields: {"hashedPassword": newHashedPassword},
      context: context,
      errorLabel: "password",
    );
  } catch (e) {
    print("Error updating password: $e");
    Default.appMsg(context, "Failed to update password. Please try again.");
    return null;
  }
}
