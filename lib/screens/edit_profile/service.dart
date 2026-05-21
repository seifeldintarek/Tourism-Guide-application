import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/models/Place.dart';


Stream<List<Place>> savedPlacesStream(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('saved')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList());
}

Future<void> deleteSavedPlace(String userId, String placeId) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('saved')
      .doc(placeId)
      .delete();
}

Future<String?> _getAuthUid(BuildContext context) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    Default.appMsg(context, "No authenticated user found.");
    return null;
  }
  return currentUser.uid;
}

/// Generic Firestore patch.  On failure, logs + shows a snack bar but does NOT
/// wipe the local cache — the caller's user object stays valid.
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

    // Merge the patched fields onto the existing map so nothing is lost.
    final updatedMap = {
      ...user.toMap(),
      ...fields,
      // Keep the ISO-8601 string Firestore serialisation expects.
      "joinedAt": user.joinedAt.toIso8601String(),
    };
    final updatedUser = AppUser.fromMap(updatedMap);
    await updatedUser.saveToCache(); // always keep cache in sync
    return updatedUser;
  } catch (e) {
    print("Error updating $errorLabel: $e");
    Default.appMsg(context, "Failed to update $errorLabel. Please try again.");
    // Return the original user so the UI doesn't lose its state.
    return user;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Name updates
// ─────────────────────────────────────────────────────────────────────────────

Future<AppUser?> updateUserFirstName(
  String newFirstName,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {"firstName": newFirstName},
  context: context,
  errorLabel: "first name",
);

Future<AppUser?> updateUserLastName(
  String newLastName,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {"lastName": newLastName},
  context: context,
  errorLabel: "last name",
);

Future<AppUser?> updateUserFullName(
  String newFirstName,
  String newLastName,
  AppUser user,
  BuildContext context,
) {
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

// ─────────────────────────────────────────────────────────────────────────────
// Password update
// ─────────────────────────────────────────────────────────────────────────────

Future<AppUser?> updateUserPassword(
  String newHashedPassword,
  AppUser user,
  BuildContext context,
) async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Default.appMsg(context, "No authenticated user found.");
      return user; // return original so caller keeps state
    }

    await currentUser.updatePassword(newHashedPassword);

    return _patchUser(
      user: user,
      fields: {"hashedPassword": newHashedPassword},
      context: context,
      errorLabel: "password",
    );
  } catch (e) {
    Default.appMsg(context, "Error updating password: $e");
    return user;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile-picture URL — Firestore only (Supabase already has the file)
// ─────────────────────────────────────────────────────────────────────────────

/// Writes the new profile-picture URL to Firestore and the local cache.
/// Returns the updated [AppUser] (or the original on failure so state is kept).
Future<AppUser?> updateProfilePictureUrl(
  String newUrl,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {"profilePictureUrl": newUrl},
  context: context,
  errorLabel: "profile picture URL",
);

// ─────────────────────────────────────────────────────────────────────────────
// Supabase storage helpers  (cache-first fallback on connection loss)
// ─────────────────────────────────────────────────────────────────────────────

final SupabaseClient supabase = Supabase.instance.client;

const String _bucketName = 'pictures';

String getUserImagePath(AppUser user) => 'pp/${user.id}.jpg';

String getPublicUrl(AppUser user) {
  try {
    final path = getUserImagePath(user);
    return supabase.storage.from(_bucketName).getPublicUrl(path);
  } catch (_) {
    return user.profilePictureUrl ?? '';
  }
}

Future<String?> uploadImage({
  required File imageFile,
  required AppUser user,
  required BuildContext context,
}) async {
  try {
    final path = getUserImagePath(user);

    await supabase.storage
        .from(_bucketName)
        .upload(path, imageFile, fileOptions: const FileOptions(upsert: true));

    final publicUrl = getPublicUrl(user);

    // Keep everything in sync immediately.
    user.profilePictureUrl = publicUrl;
    await user.saveToCache();

    return publicUrl;
  } catch (e) {
    print("Upload image error: $e");
    Default.appMsg(context, 'Failed to upload image. Please try again.');
    // Return the cached URL so the UI can still show something.
    return user.profilePictureUrl;
  }
}

Future<String?> updateImage({
  required File newImageFile,
  required AppUser user,
  required BuildContext context,
}) async {
  try {
    final path = getUserImagePath(user);

    await supabase.storage
        .from(_bucketName)
        .update(
          path,
          newImageFile,
          fileOptions: const FileOptions(upsert: true),
        );

    final publicUrl = getPublicUrl(user);

    // Sync to Firestore and cache.
    user.profilePictureUrl = publicUrl;
    await user.saveToCache();
    await FirebaseFirestore.instance.collection("users").doc(user.id).update({
      "profilePictureUrl": publicUrl,
    });

    return publicUrl;
  } catch (e) {
    print("Update image error: $e");
    // If the file didn't exist yet, fall back to a fresh upload.
    if (e.toString().contains('not found') ||
        e.toString().contains('404') ||
        e.toString().contains('Object not found')) {
      return uploadImage(imageFile: newImageFile, user: user, context: context);
    }
    Default.appMsg(context, 'Failed to update image. Please try again.');
    return user.profilePictureUrl;
  }
}

/// Deletes the user's profile picture from Supabase and clears the URL in
/// Firestore + cache.  Returns `true` on success, `false` on failure.
Future<bool> deleteImage(AppUser user, BuildContext context) async {
  try {
    final path = getUserImagePath(user);
    await supabase.storage.from(_bucketName).remove([path]);

    user.profilePictureUrl = '';
    await user.saveToCache();
    await FirebaseFirestore.instance.collection("users").doc(user.id).update({
      "profilePictureUrl": "",
    });

    return true;
  } catch (e) {
    print("Delete image error: $e");
    Default.appMsg(context, 'Failed to delete image. Please try again.');
    return false;
  }
}

Future<String> getImages(BuildContext context, AppUser user) async {
  // 1. Live object — only non-empty if a file was actually uploaded.
  final liveUrl = user.profilePictureUrl ?? '';
  if (liveUrl.isNotEmpty) return liveUrl;

  // 2. Local cache — uploaded in an earlier session.
  try {
    final cached = await AppUser.loadFromCache();
    final cachedUrl = cached?.profilePictureUrl ?? '';
    if (cachedUrl.isNotEmpty) return cachedUrl;
  } catch (e) {
    print("Cache read error in getImages: $e");
  }

  // 3. Nothing available.
  return '';
}
