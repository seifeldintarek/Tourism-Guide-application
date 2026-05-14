import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';

final List<Map<String, dynamic>> placesData = [
  {
    'title': 'Philae Temple',
    'subtitle': 'HISTORIC SITE • ASWAN',
    'color': Color(0xFFE5A967),
    'img': "assets/images/Temple of Philae.png",
  },
  {
    'title': 'Khan el-Khalili',
    'subtitle': 'MARKET • OLD CAIRO',
    'color': Color(0xFF2B211E),
    'img': "assets/images/Khan el-Khalili.png",
  },
  {
    'title': 'Siwa Oasis',
    'subtitle': 'NATURE • WESTERN DESERT',
    'color': Color(0xFF5A94C6),
    'img': "assets/images/Siwa Oasis.png",
  },
];

String name = "Julian Thorne";

Widget buildPlaceCard(String title, String subtitle, Color color, String img) {
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
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
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
                    color: Color(0xFF3B2F2F),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8A7D72),
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Color(0xFF3B2F2F)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Helper widget to build the individual numbers and labels
  Widget buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
            color: Color(0xFF3B2F2F),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8A7D72),
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }