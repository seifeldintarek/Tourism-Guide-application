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

    return Category.fromMap(categoryDoc.data()!);
  } on Exception {
    Default.appMsg(context, lang.errorgetingdata);
    return null;
  }
}

Future<List<Place>> fetchFeaturedPlacesFromDB({required String city}) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Place> places = [];
  final String selectedCity = city.toLowerCase();

  final categoriesSnapshot = await firestore.collection('category').get();

  for (final categoryDoc in categoriesSnapshot.docs) {
    final placesSnapshot = await firestore
        .collection('category')
        .doc(categoryDoc.id)
        .collection('places')
        .where('city', isEqualTo: selectedCity)
        .get();

    for (final placeDoc in placesSnapshot.docs) {
      places.add(Place.fromMap({...placeDoc.data(), 'id': placeDoc.id}));
    }
  }

  return places;
}


class SavedPlacesService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> _savedCol(String userId) =>
      _db.collection('users').doc(userId).collection('saved');

  static Future<bool> isPlaceSaved({
    required String userId,
    required String placeId,
  }) async {
    try {
      final doc = await _savedCol(userId).doc(placeId).get();
      return doc.exists;
    } catch (e) {
      debugPrint('[SavedPlacesService] isPlaceSaved error: $e');
      return false;
    }
  }


  static Future<bool> savePlace({
    required String userId,
    required Place place,
  }) async {
    try {
      final Map<String, dynamic> data = Place.toMap(place)
        ..['savedAt'] = FieldValue.serverTimestamp();

      await _savedCol(userId).doc(place.id).set(data);
      debugPrint('[SavedPlacesService] ✓ saved "${place.name}" (${place.id})');
      return true;
    } catch (e) {
      debugPrint('[SavedPlacesService] savePlace error: $e');
      return false;
    }
  }


  static Future<bool> unsavePlace({
    required String userId,
    required String placeId,
  }) async {
    try {
      await _savedCol(userId).doc(placeId).delete();
      debugPrint('[SavedPlacesService] ✓ unsaved place $placeId');
      return true;
    } catch (e) {
      debugPrint('[SavedPlacesService] unsavePlace error: $e');
      return false;
    }
  }

  static Future<bool> toggleSave({
    required String userId,
    required Place place,
  }) async {
    final bool alreadySaved = await isPlaceSaved(
      userId: userId,
      placeId: place.name,
    );

    if (alreadySaved) {
      await unsavePlace(userId: userId, placeId: place.name);
      return false;
    } else {
      await savePlace(userId: userId, place: place);
      return true;
    }
  }
}
