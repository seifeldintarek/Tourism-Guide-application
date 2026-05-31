import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/home/service.dart';

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

class MainImageHeader extends StatefulWidget {
  final Place place;
  final double height;
  final double width;
  final String locationName;

  const MainImageHeader({
    super.key,
    required this.place,
    required this.height,
    required this.width,
    required this.locationName,
  });

  @override
  State<MainImageHeader> createState() => _MainImageHeaderState();
}

class _MainImageHeaderState extends State<MainImageHeader> {
  bool? _isSaved;
  String? _userId;
  bool _toggling = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final AppUser? user = await AppUser.loadFromCache();
    if (!mounted) return;

    if (user == null) {
      setState(() {
        _userId = null;
        _isSaved = false;
      });
      return;
    }

    _userId = user.id;
    final bool saved = await SavedPlacesService.isPlaceSaved(
      userId: user.id,
      placeId: widget.place.id,
    );
    if (mounted) setState(() => _isSaved = saved);
  }

  Future<void> _onBookmarkTap() async {
    if (_toggling || _userId == null) return;
    _toggling = true;

    final bool optimistic = !(_isSaved ?? false);
    setState(() => _isSaved = optimistic);

    final bool confirmed = await SavedPlacesService.toggleSave(
      userId: _userId!,
      place: widget.place,
    );

    if (mounted && confirmed != optimistic) {
      setState(() => _isSaved = confirmed);
    }
    _toggling = false;
  }

  Widget _buildBookmarkIcon() {
    if (_isSaved == null) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 1.8, color: Colors.white),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Icon(
        _isSaved! ? Icons.bookmark : Icons.bookmark_border,
        key: ValueKey(_isSaved),
        size: 22,
        color: _isSaved! ? Colors.brown : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final lang = AppLocalizations.of(context)!;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            widget.place.mainImage,
            width: double.infinity,
            height: widget.height * .23,
            fit: BoxFit.cover,
          ),
        ),

        // Location badge (bottom-left, unchanged)
        Positioned(
          bottom: widget.height * .015,
          left: widget.width * .03,
          child: Default.locationBadge(
            label: lang.getByKey(widget.place.location),
            mapUrl: widget.place.mapUrl,
          ),
        ),

        // Bookmark button (top-right, mirrors PlaceHomeCard)
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: _onBookmarkTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (_isSaved ?? false)
                    ? Colors.white.withOpacity(.85)
                    : Colors.white.withOpacity(.35),
                shape: BoxShape.circle,
              ),
              child: _buildBookmarkIcon(),
            ),
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
