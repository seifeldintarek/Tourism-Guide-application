import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/info/service.dart';
import 'package:intl/intl.dart';
import 'widget.dart';

class Infoscreen extends StatefulWidget {
  final Place place;

  const Infoscreen({super.key, required this.place});

  @override
  State<Infoscreen> createState() => _InfoscreenState();
}

class _InfoscreenState extends State<Infoscreen> {
  Future<void> _planMyVisit() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await VisitedService.addVisitedPlace(
      uid: user.uid,
      place: widget.place,
    );
    }

    Default.navigateToExternalUrl(widget.place.bookingUrl);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    double height = MediaQuery.sizeOf(context).height,
        width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: Default.archiveAppBar(context: context, title: ""),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainImageHeader(
              place: widget.place,
              height: height,
              width: width,
              locationName: lang.getByKey(widget.place.location),
            ),
            SizedBox(height: height * .02),

            Text(
              lang.getByKey(widget.place.name),
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1C18),
                height: 1.1,
              ),
            ),
            SizedBox(height: height * .01),

            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 15),
                SizedBox(width: width * .005),
                Text(
                  '${NumberFormat('#.#', locale).format(widget.place.rating)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .01),

            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: widget.place.tags
                  .map((tag) => TagChip(label: lang.getByKey(tag)))
                  .toList(),
            ),
            SizedBox(height: height * .02),

            InfoBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Default.sectionTitle(lang.about),
                  SizedBox(height: height * .01),
                  Text(
                    lang.getByKey(widget.place.about),
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      height: 1.4,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * .02),

            InfoBox(
              backgroundColor: Color(0xFF765943),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.open,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${NumberFormat('#', locale).format(widget.place.startHr)} AM - ${NumberFormat('#', locale).format(widget.place.endHr)} PM",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * .02),

            if (widget.place.ticketPriceEgyptian != null ||
                widget.place.ticketPrice != null) ...[
              InfoBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * .02),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.confirmation_number,
                        color: Colors.red,
                        size: 14,
                      ),
                    ),
                    SizedBox(width: width * .03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.starting,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.place.ticketPriceEgyptian != null)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${lang.egyptian}: ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${lang.egp} ${NumberFormat('#', locale).format(widget.place.ticketPriceEgyptian)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.place.ticketPrice != null)
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${lang.other}: ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${lang.egp} ${NumberFormat('#', locale).format(widget.place.ticketPrice)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.normal,
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
              SizedBox(height: height * .02),
            ],

            Default.sectionTitle(
              lang.gallery,
              trailing: Text(
                '${NumberFormat('#', locale).format(widget.place.galleryImages.length)} ${lang.photos}',
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: height * .02),

            SizedBox(
              height: height * .25,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.place.galleryImages
                    .map(
                      (image) => GalleryImage(
                        imagePath: image,
                        height: height,
                        width: width,
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: height * .05),

            Default.Button(
              onPressed: _planMyVisit,
              child: lang.planMyVisit,
              width: double.infinity,
              height: height * .06,
            ),
            SizedBox(height: height * .04),
          ],
        ),
      ),
    );
  }
}
