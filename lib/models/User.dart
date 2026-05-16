import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String language;
  final String hashedPassword;

  AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
    required this.hashedPassword,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "language": language,
      "hashedPassword": hashedPassword,
    };
  }

  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      email: map["email"] ?? "",
      language: map["language"] ?? "",
      hashedPassword: map["hashedPassword"] ?? "",
      id: map["id"] ?? "",
    );
  }

  Future<void> saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_user', jsonEncode(toMap()));
  }

  // Load user from SharedPreferences
  static Future<AppUser?> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_user');
    if (cached == null) return null;
    return AppUser.fromMap(jsonDecode(cached));
  }

  // Clear cached user on logout
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_user');
  }
}
