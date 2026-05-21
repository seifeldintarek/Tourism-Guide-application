import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';

Future<bool> sendForgotPasswordEmail({
  required String email,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
    return true;
  } on FirebaseAuthException catch (e) {
    Default.appMsg(context, e.message ?? 'Failed to send reset email.');
    return false;
  } catch (e) {
    Default.appMsg(context, 'Failed to send reset email. Please try again.');
    return false;
  }
}
