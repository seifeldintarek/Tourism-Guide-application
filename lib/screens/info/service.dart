import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/Place.dart';

class VisitedService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addVisitedPlace({
    required String uid,
    required Place place,
  }) async {
    final map = Place.toMap(place);
    map['visitedAt'] = FieldValue.serverTimestamp();

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('visited')
        .doc(place.id)
        .set(map, SetOptions(merge: true));
  }
}