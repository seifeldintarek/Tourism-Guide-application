import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Default {
  static final backgroundColor = NudePalette.nudeLight;

  static const Color buttonColor = NudePalette.buttonBrown;
  static const Color textColor = NudePalette.textDark;

  static Widget Button({
    required void Function()? onPressed,
    required String? child,
    required double width,
    required double height,
    Color buttonColor = NudePalette.buttonBrown,
    Color textColor = Colors.white,
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
          ),
          elevation: 2,
        ),
        child: AutoSizeText(
          child!.toUpperCase(),
          maxLines: 1,
          style: TextStyle(
            fontSize: 13,
            color: textColor,
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

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
        icon: const Icon(
          Icons.arrow_back,
          color: NudePalette.textDark,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'NotoSerif',
          color: NudePalette.textDark,
          fontWeight: FontWeight.bold,
          letterSpacing: 4.0,
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

  static Widget sectionTitle(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'NotoSerif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: NudePalette.textDark,
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

  static Widget locationBadge({required String label, required String mapUrl}) {
    return GestureDetector(
      onTap: () => navigateToExternalUrl(mapUrl),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Colors.redAccent, size: 12),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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

  static void appMsg(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class NudePalette {
  static const Color nudeLight = Color(0xFFFEF9F2); // background
  static const Color nude = Color(0xFFE6DED4); // tags
  static const Color nudeUser = Color(0xFFFFD9A4);

  static const Color nudeBrown = Color(0xFF7A6657); // icons / small text
  static const Color nudeDark = Color(0xFF765943); // status box
  static const Color buttonBrown = Color(0xFF4B3023); // button
  static const Color textDark = Color(0xFF463427); // headings
}
