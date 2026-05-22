import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/Place.dart';

Stream<List<Place>> searchPlaces({
  required String categoryId,
  required String query,
}) {
  final lowerQuery = query.toLowerCase().trim();

  return FirebaseFirestore.instance
      .collection("category")
      .doc(categoryId)
      .collection("places")
      .snapshots()
      .map((snapshot) {
        final allPlaces = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return Place.fromMap(data);
        }).toList()..sort((a, b) => b.rating.compareTo(a.rating));

        if (lowerQuery.isEmpty) return allPlaces;

        return allPlaces
            .where(
              (place) =>
                  place.name.toLowerCase().contains(lowerQuery) ||
                  place.city.toLowerCase().contains(lowerQuery),
            )
            .toList();
      });
}
