import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Default {
  // Usage: get width and height of screen
  // double width = MediaQuery.of(context).size.width,
  //        height = MediaQuery.of(context).size.height;

  static final backgroundColor =
      NudePalette.nudeLight; // Updated to use your palette
  static final buttonColor = Color(
    0xFF463427,
  ); // Matching the primary color from your HTML

  static Widget Button({
    required void Function()? onPressed,
    required String? child,
    required double width,
    required double height,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ), // Matching the 'xl' style in HTML
        ),
        child: Text(
          child!.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'WorkSans', // Added WorkSans
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  // Standard App Bar for "THE ARCHIVE"
  static PreferredSizeWidget archiveAppBar({
    required BuildContext context,
    required String title,
    Widget? trailingIcon,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF463427), size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'NotoSerif', // Updated from 'Tes' to 'NotoSerif'
          color: Color(0xFF463427),
          fontWeight: FontWeight.bold,
          letterSpacing:
              4.0, // Increased tracking to match your HTML tracking-widest
          fontSize: 18,
        ),
      ),
      actions: [
        if (trailingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: trailingIcon,
          ),
      ],
    );
  }

  // Reusable Section Title (e.g., "About the Archive", "Visual Archive")
  static Widget sectionTitle(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'NotoSerif', // Using Serif for section headers
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle:
                FontStyle.italic, // Matching the HTML 'italic' class for About
            color: Color(0xFF463427),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  static Future<void> navigateToExternalUrl(String urlPath) async {
    final Uri url = Uri.parse(urlPath);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }

  // 1. Reusable Location Badge Widget
  static Widget locationBadge({required String label, required String mapUrl}) {
    return GestureDetector(
      onTap: () => navigateToExternalUrl(mapUrl),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Shrinks box to fit text
            children: [
              const Icon(Icons.location_on, color: Colors.redAccent, size: 14),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'WorkSans',
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NudePalette {
  static const Color nudeLight = Color(
    0xFFFEF9F2,
  ); // Updated to match HTML surface-bright
  static const Color nude = Color(
    0xFFF4DFCB,
  ); // Updated to match HTML secondary-container
  static const Color nudePink = Color(0xFFD8A7A0);
  static const Color nudeBrown = Color(
    0xFF80756D,
  ); // Updated to match HTML outline
  static const Color nudeDark = Color(
    0xFF463427,
  ); // Updated to match HTML primary
}
