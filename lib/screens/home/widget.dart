import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/category/category.dart';
import 'package:flutter_application_1/screens/home/service.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:google_fonts/google_fonts.dart';

Widget header({
  required double width,
  required double height,
  required AppLocalizations lang,
  required String name,
}) {
  return Container(
    padding: EdgeInsets.only(left: width * .1),
    height: height * .28,
    width: width,
    color: Color(0xFFFCDFCF),
    child: Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(height: height * .04),
        Text(
          "${lang.goodmorning.toUpperCase()}, ${name}",
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
    scrollDirection: .horizontal,
    itemCount: places.length,
    itemBuilder: (context, i) {
      return placeHomeCard(
        place: places[i],
        height: height,
        width: width,
        context: context,
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

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.35),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_border,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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
                        place.name,
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
                              "${place.location}, ${place.city}",
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
                        place.rating.toString(),
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
