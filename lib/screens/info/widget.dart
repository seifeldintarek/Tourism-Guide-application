import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:url_launcher/url_launcher.dart';

class TagChip extends StatelessWidget {
  final String label;
  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: NudePalette.nude,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class MainImageHeader extends StatelessWidget {
  const MainImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Main Cover Image
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/images/museum.png',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),

        // 2. The EST. 1902 Circular Badge
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54, width: 1),
              color: Colors.black.withOpacity(0.3),
            ),
            child: const Column(
              children: [
                Text(
                  'EST.',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
                Text(
                  '1902',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'CAIRO',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ],
            ),
          ),
        ),

        // 3. The New Reusable Location Badge from Default class
        Positioned(
          bottom: 16,
          left: 16,
          child: Default.locationBadge(
            label: 'Tahrir Sq',
            mapUrl: 'https://maps.google.com/?q=Egyptian+Museum+Tahrir',
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
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
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}
