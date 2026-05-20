import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/Place.dart';

Future<List<Place>> fetchCategoryPlaces(String categoryName) async {
  final placesCollection = FirebaseFirestore.instance
      .collection("category")
      .doc(categoryName.toLowerCase())
      .collection("places");

  final snapshot = await placesCollection.get();

  if (snapshot.docs.isNotEmpty) {
    List<Place> places = snapshot.docs
        .map((doc) => Place.fromMap(doc.data()))
        .toList();

    return places;
  }
  return [];
}
