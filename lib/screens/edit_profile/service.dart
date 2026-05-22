import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Stream<List<Place>> savedPlacesStream(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('saved')
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList(),
      );
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

Future<AppUser?> updateUserFirstName(
  String newFirstName,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {'firstName': newFirstName},
  context: context,
  errorLabel: 'first name',
);

Future<AppUser?> updateUserLastName(
  String newLastName,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {'lastName': newLastName},
  context: context,
  errorLabel: 'last name',
);

Future<AppUser?> updateUserFullName(
  String newFirstName,
  String newLastName,
  AppUser user,
  BuildContext context,
) {
  final newFullName = '$newFirstName $newLastName'.trim();
  return _patchUser(
    user: user,
    fields: {
      'firstName': newFirstName,
      'lastName': newLastName,
      'fullName': newFullName,
    },
    context: context,
    errorLabel: 'full name',
  );
}

Future<AppUser?> updateProfilePictureUrl(
  String newUrl,
  AppUser user,
  BuildContext context,
) => _patchUser(
  user: user,
  fields: {'profilePictureUrl': newUrl},
  context: context,
  errorLabel: 'profile picture URL',
);

final SupabaseClient supabase = Supabase.instance.client;

const String _bucketName = 'pictures';

String getUserImagePath(AppUser user) => 'pp/${user.id}.jpg';

String getPublicUrl(AppUser user, {int? version}) {
  try {
    final path = getUserImagePath(user);
    final base = supabase.storage.from(_bucketName).getPublicUrl(path);
    final v = version ?? DateTime.now().millisecondsSinceEpoch;
    return '$base?v=$v';
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

    user.profilePictureUrl = publicUrl;
    await user.saveToCache();

    return publicUrl;
  } catch (e) {
    debugPrint('Upload image error: $e');
    Default.appMsg(context, 'Failed to upload image. Please try again.');
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

    user.profilePictureUrl = publicUrl;
    await user.saveToCache();
    await FirebaseFirestore.instance.collection('users').doc(user.id).update({
      'profilePictureUrl': publicUrl,
    });

    return publicUrl;
  } catch (e) {
    debugPrint('Update image error: $e');
    if (e.toString().contains('not found') ||
        e.toString().contains('404') ||
        e.toString().contains('Object not found')) {
      return uploadImage(imageFile: newImageFile, user: user, context: context);
    }
    Default.appMsg(context, 'Failed to update image. Please try again.');
    return user.profilePictureUrl;
  }
}

Future<bool> deleteImage(AppUser user, BuildContext context) async {
  try {
    final path = getUserImagePath(user);
    await supabase.storage.from(_bucketName).remove([path]);

    user.profilePictureUrl = '';
    await user.saveToCache();
    await FirebaseFirestore.instance.collection('users').doc(user.id).update({
      'profilePictureUrl': '',
    });

    return true;
  } catch (e) {
    debugPrint('Delete image error: $e');
    Default.appMsg(context, 'Failed to delete image. Please try again.');
    return false;
  }
}

Future<String> getImages(BuildContext context, AppUser user) async {
  final liveUrl = user.profilePictureUrl ?? '';
  if (liveUrl.isNotEmpty) return liveUrl;

  try {
    final cached = await AppUser.loadFromCache();
    final cachedUrl = cached?.profilePictureUrl ?? '';
    if (cachedUrl.isNotEmpty) return cachedUrl;
  } catch (e) {
    debugPrint('Cache read error in getImages: $e');
  }

  return '';
}
