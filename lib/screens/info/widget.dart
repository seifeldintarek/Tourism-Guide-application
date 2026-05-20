import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/Place.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE6DED4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          color: Color(0xFF7A6657),
          letterSpacing: 0.2,
          fontFamily: 'WorkSans',
        ),
      ),
    );
  }
}

class MainImageHeader extends StatelessWidget {
  final Place place;

  const MainImageHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            place.mainImage,
            width: double.infinity,
            height: 185,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          child: Default.locationBadge(
            label: place.location,
            mapUrl: place.mapUrl,
          ),
        ),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const InfoBox({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFE9E4DD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String imagePath;

  const GalleryImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 75,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
