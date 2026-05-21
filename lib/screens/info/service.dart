import 'package:cloud_firestore/cloud_firestore.dart';

class VisitedService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addVisitedPlace({
    required String uid,
    required String id,
    required String name,
    required String city,
    required String category,
    required String mainImage,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('visited')
        .doc(id)
        .set({
          'id': id,
          'name': name,
          'city': city,
          'category': category,
          'mainImage': mainImage,
          'visitedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }
}
