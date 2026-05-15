class AppUser {
  final String firstName;
  final String lastName;
  final String email;
  final String language;
  final String hashedPassword;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
    required this.hashedPassword,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
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
    );
  }
}
