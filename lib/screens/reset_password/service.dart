import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';

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

    await FirebaseFirestore.instance.collection('users').doc(user.id).update(fields);

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

Future<AppUser?> updateUserPassword({
  required String newHashedPassword,
  required AppUser user,
  required BuildContext context,
}) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Default.appMsg(context, 'No authenticated user found.');
      return user;
    }

    await currentUser.updatePassword(newHashedPassword);

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
