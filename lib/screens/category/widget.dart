import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:flutter_application_1/screens/search/widget.dart';
import 'package:flutter_application_1/root/themes.dart';

Widget mainImage(BuildContext context, String? url, double height) {
  return Container(
    height: height * .3,
    width: double.infinity,
    child: url != null
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => SizedBox(
              child: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            ),
            fit: BoxFit.cover,
          )
        : Image.asset("assets/images/placeholder/placeholder.jpg"),
  );
}

Widget getCategoryPlaces(
  BuildContext context,
  double height,
  double width,
  AppLocalizations lang,
  List<Place> places,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: width * .03),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: places.length,
      itemBuilder: (context, i) {
        final place = places[i];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Infoscreen(place: place)),
            );
          },
          child: buildPlaceCard(
            Place(
              id: place.id,
              name: place.name,
              location: place.location,
              city: place.city,
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
          ),
        );
      },
    ),
  );
}
