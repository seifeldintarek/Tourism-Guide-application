import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';

// ── User stream ───────────────────────────────────────────────────────────────
Stream<AppUser> userStream(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>));
}

// ── Visited places stream ─────────────────────────────────────────────────────
Stream<List<Place>> visitedPlacesStream(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('visited')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList());
}

// ── Saved places stream ───────────────────────────────────────────────────────
Stream<List<Place>> savedPlacesStream(String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('saved')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Place.fromMap(doc.data())).toList());
}