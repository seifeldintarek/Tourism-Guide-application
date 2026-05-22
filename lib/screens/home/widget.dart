import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/category/category.dart';
import 'package:flutter_application_1/screens/home/service.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    color: Color(0xFFFCDFCF),
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

Widget categories({
  required BuildContext context,
  required double height,
  required double width,
  required AppLocalizations lang,
}) {
  List<String> categories = [
    lang.heritage,
    lang.nature,
    lang.spiritual,
    lang.food,
  ];

  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    padding: EdgeInsets.symmetric(horizontal: width * .05),
    separatorBuilder: (context, index) => SizedBox(width: width * .03),
    itemBuilder: (context, i) {
      return Default.Button(
        onPressed: () async {
          Category? category = await fetchCategory(
            categoryName: categories[i],
            context: context,
            lang: lang,
          );

          if (category == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Category_Screen(category: category),
            ),
          );
        },
        child: categories[i],
        width: width * .4,
        height: height * .05,
      );
    },
  );
}

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
    separatorBuilder: (context, index) => SizedBox(width: width * .03),
    itemBuilder: (context, i) {
      return PlaceHomeCard(
        place: places[i],
        height: height,
        width: width,
        context: context,
      );
    },
  );
}

class PlaceHomeCard extends StatefulWidget {
  final Place place;
  final double height;
  final double width;
  final BuildContext context;

  const PlaceHomeCard({
    super.key,
    required this.place,
    required this.height,
    required this.width,
    required this.context,
  });

  @override
  State<PlaceHomeCard> createState() => _PlaceHomeCardState();
}

class _PlaceHomeCardState extends State<PlaceHomeCard> {
  bool _isSaved = false;
  bool _loading = true;
  bool _toggling = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    final AppUser? user = await AppUser.loadFromCache();

    if (user == null) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      return;
    }

    _userId = user.id;

    final saved = await SavedPlacesService.isPlaceSaved(
      userId: user.id,
      placeId: widget.place.name.toLowerCase(),
    );

    if (mounted) {
      setState(() {
        _isSaved = saved;
        _loading = false;
      });
    }
  }

  Future<void> _toggleSave() async {
    if (_toggling || _userId == null) return;

    _toggling = true;

    final optimistic = !_isSaved;

    setState(() {
      _isSaved = optimistic;
    });

    final confirmed = await SavedPlacesService.toggleSave(
      userId: _userId!,
      place: widget.place,
    );

    if (mounted && confirmed != optimistic) {
      setState(() {
        _isSaved = confirmed;
      });
    }

    _toggling = false;
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Infoscreen(place: widget.place),
        ),
      ),
      child: Container(
        width: widget.width * .6,
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
                    imageUrl: widget.place.mainImage,
                    height: widget.height * .28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _toggleSave,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.35),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.width * .03,
                vertical: widget.height * .01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.getByKey(widget.place.name),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "Serif",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
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
                                "${lang.getByKey(widget.place.location)}, ${lang.getByKey(widget.place.city)}",
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
                          NumberFormat(
                            '#.#',
                            locale,
                          ).format(widget.place.rating),
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
}
