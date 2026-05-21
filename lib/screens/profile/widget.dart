import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/Place.dart';

// ── Tab button ────────────────────────────────────────────────────────────────
Widget buildTabButton({
  required String label,
  required bool isSelected,
  required double width,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            fontFamily: 'Times New Roman',
            color: isSelected ? Colors.black87 : NudePalette.nudeBrown,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 2,
          width: isSelected ? width * 0.12 : 0,
          decoration: BoxDecoration(
            color: Default.buttonColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ),
  );
}

// ── Empty state ───────────────────────────────────────────────────────────────
Widget buildEmptyState({required IconData icon, required String message}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 32),
    child: Center(
      child: Column(
        children: [
          Icon(icon, size: 48, color: NudePalette.nudeBrown),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Times New Roman',
              color: NudePalette.nudeBrown,
            ),
          ),
        ],
      ),
    ),
  );
}

// ── Place card ────────────────────────────────────────────────────────────────
Widget buildPlaceCard(Place place, {bool isBookmarked = false}) {
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
            errorWidget: (context, url, error) => Container(
              width: 56,
              height: 56,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported, size: 24),
            ),
          ),
        ),
        const SizedBox(width: 16),
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
              const SizedBox(height: 4),
              Text(
                ' • ${place.city.toUpperCase()}',
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
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? Default.buttonColor : NudePalette.nudeDark,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}

// ── Places list ───────────────────────────────────────────────────────────────
Widget buildPlacesList({required List<Place> places, required double height, bool isBookmarked = false,}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: places.length,
    separatorBuilder: (_, __) => SizedBox(height: height * 0.013),
    itemBuilder: (_, index) => buildPlaceCard(places[index], isBookmarked: isBookmarked),
  );
}

// ── Stat column ───────────────────────────────────────────────────────────────
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
