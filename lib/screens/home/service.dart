import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';

Future<Category?> fetchCategory({
  required String categoryName,
  required BuildContext context,
  required AppLocalizations lang,
}) async {
  try {
    final categoryDoc = await FirebaseFirestore.instance
        .collection("category")
        .doc(categoryName.toLowerCase())
        .get();
    Category category = Category.fromMap(categoryDoc.data()!);
    return category;
  } on Exception catch (e) {
    Default.appMsg(context, lang.errorgetingdata);
    return null;
  }
}

Future<List<Place>> fetchFeaturedPlacesFromDB({required String city}) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Place> places = [];
  final String selectedCity = city.toLowerCase();

  final categoriesSnapshot = await firestore.collection('category').get();

  for (var categoryDoc in categoriesSnapshot.docs) {
    final placesSnapshot = await firestore
        .collection('category')
        .doc(categoryDoc.id)
        .collection('places')
        .where('city', isEqualTo: selectedCity)
        .get();

    for (var placeDoc in placesSnapshot.docs) {
      final data = placeDoc.data();

      places.add(Place.fromMap({...data, 'id': placeDoc.id}));
    }
  }

  return places;
}
