import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/Place.dart'; // add this
import 'package:cached_network_image/cached_network_image.dart'; // add this if not there

Widget buildPlaceCard(Place place) { // now takes a Place directly
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F4EF),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: place.mainImage,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 56,
              height: 56,
              color: Colors.grey.shade200,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: NudePalette.nudeDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${place.location.toUpperCase()} • ${place.city.toUpperCase()}',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: NudePalette.nudeBrown,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.bookmark_border, color: NudePalette.nudeDark),
          onPressed: () {},
        ),
      ],
    ),
  );
}

// Helper widget to build the individual numbers and labels
Widget buildStatColumn(String number, String label, double height) {
  return Column(
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
          color: NudePalette.nudeDark,
        ),
      ),
      SizedBox(height: height),
      Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: NudePalette.nudeBrown,
          letterSpacing: 1.2,
        ),
      ),
    ],
  );
}
