import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/category/category.dart';
import 'package:flutter_application_1/screens/home/service.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  header
// ─────────────────────────────────────────────────────────────────────────────

Widget header({
  required double width,
  required double height,
  required AppLocalizations lang,
  required String name,
}) {
  return Container(
    padding: EdgeInsets.only(left: width * .1),
    height: height * .25,
    width: width,
    color: const Color(0xFFFCDFCF),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * .04),
        Text(
          "${lang.goodmorning.toUpperCase()}, $name",
          style: TextStyle(
            fontFamily: "Sans-Serif",
            fontSize: 11,
            color: Default.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: height * .005),

        Text(
          lang.discover,
          style: TextStyle(
            fontFamily: "Serif",
            fontSize: 25,
            color: Default.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          lang.hidden,
          style: GoogleFonts.cormorantGaramond(
            fontWeight: FontWeight.normal,
            fontSize: 25,
            color: Default.textColor,
          ),
        ),
        Text(
          lang.treasures,
          style: TextStyle(
            fontFamily: "Serif",
            fontSize: 25,
            color: Default.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  categories
// ─────────────────────────────────────────────────────────────────────────────

Widget categories({
  required BuildContext context,
  required double height,
  required double width,
  required AppLocalizations lang,
}) {
  final List<String> cats = [
    lang.heritage,
    lang.nature,
    lang.spiritual,
    lang.food,
  ];

  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: cats.length,
    padding: EdgeInsets.symmetric(horizontal: width * .05),
    separatorBuilder: (_, __) => SizedBox(width: width * .03),
    itemBuilder: (context, i) {
      return Default.Button(
        onPressed: () async {
          final Category? category = await fetchCategory(
            categoryName: cats[i],
            context: context,
            lang: lang,
          );
          if (category == null) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Category_Screen(category: category),
            ),
          );
        },
        child: cats[i],
        width: width * .4,
        height: height * .05,
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  featuredPlaces
// ─────────────────────────────────────────────────────────────────────────────

Widget featuredPlaces({
  required List<Place> places,
  required BuildContext context,
  required double height,
  required double width,
  required AppLocalizations lang,
}) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: places.length,
    itemBuilder: (context, i) {
      return placeHomeCard(
        place: places[i],
        height: height,
        width: width,
        context: context,
        lang: lang,
      );
    },
    separatorBuilder: (context, index) => SizedBox(width: width * .03),
  );
}

Widget placeHomeCard({
  required Place place,
  required double height,
  required double width,
  required BuildContext context,
  required AppLocalizations lang,
}) {
  return InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Infoscreen(place: place)),
    ),
    child: Container(
      width: width * .6,
      decoration: BoxDecoration(
        color: Default.backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: CachedNetworkImage(
                  imageUrl: place.mainImage,
                  height: height * .28,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
    separatorBuilder: (_, __) => SizedBox(width: width * .03),
    itemBuilder: (_, i) => PlaceHomeCard(
      place: places[i],
      height: height,
      width: width,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  PlaceHomeCard
//
//  Loads the current user from AppUser.loadFromCache() internally.
//  Parent only needs to pass the Place and the responsive sizes.
// ─────────────────────────────────────────────────────────────────────────────

class PlaceHomeCard extends StatefulWidget {
  final Place place;
  final double height;
  final double width;

  /// Supply this if you already know the saved state to skip one Firestore read.
  final bool? initialSaved;

  const PlaceHomeCard({
    super.key,
    required this.place,
    required this.height,
    required this.width,
    this.initialSaved,
  });

  @override
  State<PlaceHomeCard> createState() => _PlaceHomeCardState();
}

class _PlaceHomeCardState extends State<PlaceHomeCard> {
  // null  → still resolving (spinner shown)
  // true  → saved
  // false → not saved
  bool? _isSaved;

  // Cached user id — loaded once on mount.
  String? _userId;

  // Guards against rapid taps firing concurrent Firestore calls.
  bool _toggling = false;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

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

    if (widget.initialSaved != null) {
      setState(() => _isSaved = widget.initialSaved);
    } else {
      final bool saved = await SavedPlacesService.isPlaceSaved(
        userId: user.id,
        placeId: widget.place.id,
      );
      if (mounted) setState(() => _isSaved = saved);
    }
  }

  // ── Bookmark toggle ───────────────────────────────────────────────────────

  Future<void> _onBookmarkTap() async {
    if (_toggling || _userId == null) return;
    _toggling = true;

    // Optimistic flip — icon responds instantly.
    final bool optimistic = !(_isSaved ?? false);
    setState(() => _isSaved = optimistic);

    // Persist to Firestore.
    final bool confirmed = await SavedPlacesService.toggleSave(
      userId: _userId!,
      place: widget.place,
    );

    // Roll back if Firestore returned a different result.
    if (mounted && confirmed != optimistic) {
      setState(() => _isSaved = confirmed);
    }

    _toggling = false;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final double w = widget.width;
    final double h = widget.height;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Infoscreen(place: widget.place)),
      ),
      child: Container(
        width: w * .6,
        decoration: BoxDecoration(
          color: Default.backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image + bookmark ──────────────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.place.mainImage,
                    height: h * .28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * .03,
              vertical: height * .01,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.getByKey(place.name),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Serif",
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
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
            ),

            // ── Name · location · rating ──────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * .03,
                vertical: h * .01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.place.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "Serif",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              "${lang.getByKey(place.location)}, ${lang.getByKey(place.city)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 12,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                '${widget.place.location}, ${widget.place.city}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Rating badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4DDC8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 11, color: Colors.brown),
                        const SizedBox(width: 3),
                        Text(
                          widget.place.rating.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bookmark icon ─────────────────────────────────────────────────────────

  Widget _buildBookmarkIcon() {
    if (_isSaved == null) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 1.8,
          color: Colors.white,
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Icon(
        _isSaved! ? Icons.bookmark : Icons.bookmark_border,
        key: ValueKey(_isSaved),
        size: 18,
        color: _isSaved! ? Colors.brown : Colors.white,
      ),
    );
  }
}