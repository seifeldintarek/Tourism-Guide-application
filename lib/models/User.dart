import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String language;
  final String hashedPassword;
  final DateTime joinedAt;
  String? profilePictureUrl;

  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.language,
    required this.hashedPassword,
    required this.joinedAt,
    this.profilePictureUrl,
  });

  static const String cacheKey = 'cached_user';

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "fullName": fullName,
      "email": email,
      "language": language,
      "hashedPassword": hashedPassword,
      "joinedAt": joinedAt.toIso8601String(),
      "profilePictureUrl": profilePictureUrl,
    };
  }

  static AppUser fromMap(Map<String, dynamic> map) {
    DateTime parsedJoinedAt;

    if (map["joinedAt"] is Timestamp) {
      parsedJoinedAt = (map["joinedAt"] as Timestamp).toDate();
    } else if (map["JoinedAt"] is Timestamp) {
      parsedJoinedAt = (map["JoinedAt"] as Timestamp).toDate();
    } else if (map["joinedAt"] != null) {
      parsedJoinedAt = DateTime.parse(map["joinedAt"]);
    } else if (map["JoinedAt"] != null) {
      parsedJoinedAt = DateTime.parse(map["JoinedAt"]);
    } else {
      parsedJoinedAt = DateTime.now();
    }

    return AppUser(
      id: map["id"] ?? "",
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      fullName: map["fullName"] ?? "",
      email: map["email"] ?? "",
      language: map["language"] ?? "",
      hashedPassword: map["hashedPassword"] ?? "",
      joinedAt: parsedJoinedAt,
      profilePictureUrl: map["profilePictureUrl"],
    );
  }

  Future<void> saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(toMap()));
  }

  static Future<AppUser?> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedUser = prefs.getString(cacheKey);

    if (cachedUser == null) {
      return null;
    }

    final Map<String, dynamic> userMap = jsonDecode(cachedUser);

    return AppUser.fromMap(userMap);
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
  }

  static Future<void> updateCachedProfilePicture(String imageUrl) async {
    final user = await AppUser.loadFromCache();

    if (user == null) return;

    user.profilePictureUrl = imageUrl;

    await user.saveToCache();
  }
}
