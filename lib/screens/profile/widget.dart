import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';

final List<Map<String, dynamic>> placesData = [
  {
    'title': 'Philae Temple',
    'subtitle': 'HISTORIC SITE • ASWAN',
    'img': "assets/images/Temple of Philae.png",
  },
  {
    'title': 'Khan el-Khalili',
    'subtitle': 'MARKET • OLD CAIRO',
    'img': "assets/images/Khan el-Khalili.png",
  },
  {
    'title': 'Siwa Oasis',
    'subtitle': 'NATURE • WESTERN DESERT',
    'img': "assets/images/Siwa Oasis.png",
  },
];

String name = "Julian Thorne";

Widget buildPlaceCard(String title, String subtitle, String img) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF7F4EF), // Very light beige card bg
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: NudePalette.nudeDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
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
