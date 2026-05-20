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
  final double height;
  final double width;

  const MainImageHeader({
    super.key,
    required this.place,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            place.mainImage,
            width: double.infinity,
            height: height * .23,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: height * .015,
          left: width * .03,
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
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * .035),
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
  final double height;
  final double width;

  const GalleryImage({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: width * .025),
      width: width * .19,
      height: height * .11,
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
