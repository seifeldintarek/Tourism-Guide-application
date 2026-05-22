import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Internal helpers
// ─────────────────────────────────────────────────────────────────────────────

Future<String?> _getAuthUid(BuildContext context) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    Default.appMsg(context, 'No authenticated user found.');
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

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(fields);

    final updatedMap = {
      ...user.toMap(),
      ...fields,
      'joinedAt': user.joinedAt.toIso8601String(),
    };

    final updatedUser = AppUser.fromMap(updatedMap);
    await updatedUser.saveToCache();
    return updatedUser;
  } catch (e) {
    debugPrint('Error updating $errorLabel: $e');
    Default.appMsg(context, 'Failed to update $errorLabel. Please try again.');
    return user;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Re-authenticate the current Firebase user with their plain-text password.
//
// Firebase Auth manages its own credential store — it never receives hashed
// passwords.  Hashing is only applied before writing to Firestore.
// ─────────────────────────────────────────────────────────────────────────────
Future<bool> _reauthenticate({
  required User firebaseUser,
  required String plainOldPassword, // the raw value from the text field
  required BuildContext context,
}) async {
  try {
    final email = firebaseUser.email;
    if (email == null || email.isEmpty) {
      Default.appMsg(context, 'Cannot verify identity: no email on account.');
      return false;
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password:
          plainOldPassword, // must be plain-text — Firebase hashes internally
    );

    await firebaseUser.reauthenticateWithCredential(credential);
    return true;
  } on FirebaseAuthException catch (e) {
    // wrong-password / user-mismatch both surface here
    Default.appMsg(
      context,
      e.code == 'wrong-password'
          ? 'Current password is incorrect.'
          : (e.message ?? 'Re-authentication failed.'),
    );
    return false;
  } catch (e) {
    Default.appMsg(context, 'Re-authentication error: $e');
    return false;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Update password — direct flow (user knows old password)
//
// Steps:
//   1. Re-authenticate with Firebase using the plain old password.
//      This also proves the old password is correct, so the manual hash
//      comparison in _validate() is a useful UI-layer guard but Firebase
//      is the authoritative check.
//   2. Call updatePassword() with the plain NEW password so Firebase Auth
//      stays consistent with future sign-ins.
//   3. Write only the *hashed* new password to Firestore (never plain text).
// ─────────────────────────────────────────────────────────────────────────────
Future<AppUser?> updateUserPassword({
  required String plainOldPassword, // raw value from "current password" field
  required String plainNewPassword, // raw value from "new password" field
  required String
  newHashedPassword, // hashPassword(plainNewPassword) — stored in Firestore
  required AppUser user,
  required BuildContext context,
}) async {
  try {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      Default.appMsg(context, 'No authenticated user found.');
      return user;
    }

    // Step 1 — re-authenticate (validates old password against Firebase Auth)
    final reauthed = await _reauthenticate(
      firebaseUser: firebaseUser,
      plainOldPassword: plainOldPassword,
      context: context,
    );
    if (!reauthed) return null; // error message already shown

    // Step 2 — update Firebase Auth with the plain new password
    await firebaseUser.updatePassword(plainNewPassword);

    // Step 3 — persist only the hash in Firestore
    return _patchUser(
      user: user,
      fields: {'hashedPassword': newHashedPassword},
      context: context,
      errorLabel: 'password',
    );
  } on FirebaseAuthException catch (e) {
    Default.appMsg(context, e.message ?? 'Error updating password.');
    return user;
  } catch (e) {
    Default.appMsg(context, 'Error updating password: $e');
    return user;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Send a password-reset e-mail — email flow
//
// Firebase sends a secure link to the address.  When the user clicks it they
// are taken to a reset form managed by Firebase; your app does not handle the
// new password directly in this flow.
//
// After the user completes the email reset and signs in again, call
// syncPasswordHashAfterEmailReset() (below) to keep Firestore in sync.
// ─────────────────────────────────────────────────────────────────────────────
Future<bool> sendPasswordResetEmail({
  required String email,
  required BuildContext context,
}) async {
  try {
    if (email.trim().isEmpty) {
      Default.appMsg(context, 'Please enter your email address.');
      return false;
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());

    Default.appMsg(
      context,
      'A password-reset link has been sent to $email. '
      'Please check your inbox and follow the instructions.',
    );
    return true;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'user-not-found':
        Default.appMsg(context, 'No account found for that email address.');
        break;
      case 'invalid-email':
        Default.appMsg(context, 'The email address is not valid.');
        break;
      case 'too-many-requests':
        Default.appMsg(
          context,
          'Too many attempts. Please wait a moment and try again.',
        );
        break;
      default:
        Default.appMsg(context, e.message ?? 'Failed to send reset email.');
    }
    return false;
  } catch (e) {
    Default.appMsg(context, 'Error sending reset email: $e');
    return false;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// After the user completes the email-reset flow and signs back in, call this
// to update Firestore with the new hashed password so both stores stay in sync.
//
// Usage: call this once inside your post-login handler when you detect that
// the stored hashedPassword no longer matches what the user just typed.
// ─────────────────────────────────────────────────────────────────────────────
Future<AppUser?> syncPasswordHashAfterEmailReset({
  required String plainNewPassword, // what the user just signed in with
  required String newHashedPassword, // hashPassword(plainNewPassword)
  required AppUser user,
  required BuildContext context,
}) async {
  return _patchUser(
    user: user,
    fields: {'password': newHashedPassword},
    context: context,
    errorLabel: 'password sync',
  );
}
