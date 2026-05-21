import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:flutter_application_1/screens/search/service.dart';
import 'package:flutter_application_1/root/themes.dart';

Widget searchTextfield(
  BuildContext context,
  double height,
  double width,
  TextEditingController controller,
  AppLocalizations lang,
  String? categoryId,
  ValueNotifier<String> queryNotifier,
  Widget Function(Place place) cardBuilder,
) {
  return Column(
    children: [
      Container(
        height: height * .06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * .1),
        ),
        child: TextField(
          controller: controller,
          cursorHeight: height * 0.022,
          onChanged: (val) => queryNotifier.value = val,
          decoration: InputDecoration(
            hintText: lang.searchDestination,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon: Icon(
              Icons.travel_explore,
              color: Colors.grey.shade600,
              size: width * .055,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: height * 0.018),
          ),
        ),
      ),

      SizedBox(height: height * .02),

      ValueListenableBuilder<String>(
        valueListenable: queryNotifier,
        builder: (context, query, _) {
          if (categoryId == null) return const SizedBox();

          return StreamBuilder<List<Place>>(
            stream: searchPlaces(categoryId: categoryId, query: query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: EdgeInsets.only(top: height * .03),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final results = snapshot.data ?? [];

              if (results.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: height * .03),
                  child: Center(
                    child: Text(
                      query.isEmpty
                          ? "No places in this category."
                          : "No results for \"$query\"",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final place = results[index];

                  return buildPlaceCard(
                    Place(
                      id: place.id,
                      name: lang.getByKey(place.name),
                      location: lang.getByKey(place.location),
                      city: lang.getByKey(place.city),
                      mainImage: place.mainImage,
                      category: place.category,
                      rating: place.rating,
                      about: place.about,
                      tags: place.tags,
                      startHr: place.startHr,
                      endHr: place.endHr,
                      ticketPrice: place.ticketPrice,
                      galleryImages: place.galleryImages,
                      mapUrl: place.mapUrl,
                      bookingUrl: place.bookingUrl,
                      ticketPriceEgyptian: place.ticketPriceEgyptian,
                    ),
                    originalPlace: place,
                  );
                },
              );
            },
          );
        },
      ),
    ],
  );
}

Widget buildPlaceCard(Place place, {Place? originalPlace}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final locale = Localizations.localeOf(context).languageCode;
      final lang = AppLocalizations.of(context)!;
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      return Container(
        margin: EdgeInsets.only(bottom: height * .015),
        decoration: BoxDecoration(
          color: Color(0xFFE6DED4),
          borderRadius: BorderRadius.circular(width * .04),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * .03,
            vertical: height * .008,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(width * .03),
            child: Image.network(
              place.mainImage,
              width: width * .14,
              height: width * .14,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: width * .14,
                height: width * .14,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          title: Text(
            place.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Default.textColor,
            ),
          ),
          subtitle: Text(
            "${lang.getByKey(place.city)} • ${place.startHr}:00–${place.endHr}:00",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: width * .06,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Infoscreen(place: originalPlace ?? place),
              ),
            );
          },
        ),
      );
    },
  );
}
