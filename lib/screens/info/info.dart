import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/info/service.dart';
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
        id: widget.place.id,
        name: widget.place.name,
        city: widget.place.city,
        category: widget.place.category,
      );
    }

    Default.navigateToExternalUrl(widget.place.bookingUrl);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: Default.archiveAppBar(context: context, title: ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainImageHeader(place: widget.place),
            const SizedBox(height: 14),

            Text(
              widget.place.name,
              style: const TextStyle(
                fontFamily: 'NotoSerif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1C18),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 15),
                const SizedBox(width: 4),
                Text(
                  '${widget.place.rating}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: widget.place.tags
                  .map((tag) => TagChip(label: tag))
                  .toList(),
            ),
            const SizedBox(height: 14),

            InfoBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Default.sectionTitle(lang.about),
                  const SizedBox(height: 8),
                  Text(
                    widget.place.about,
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      height: 1.4,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            InfoBox(
              backgroundColor: const Color(0xFF765943),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.open,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.place.startHr} AM - ${widget.place.endHr} PM",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            if (widget.place.ticketPriceEgyptian != null ||
                widget.place.ticketPrice != null) ...[
              InfoBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.confirmation_number,
                        color: Colors.red,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.starting,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.place.ticketPriceEgyptian != null)
                            Text(
                              '${lang.egyptian}: ${lang.egp} ${widget.place.ticketPriceEgyptian}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (widget.place.ticketPrice != null)
                            Text(
                              '${lang.other}: ${lang.egp} ${widget.place.ticketPrice}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            Default.sectionTitle(
              lang.gallery,
              trailing: Text(
                '${widget.place.galleryImages.length} ${lang.photos}',
                style: const TextStyle(
                  fontSize: 9,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.place.galleryImages
                    .map((image) => GalleryImage(imagePath: image))
                    .toList(),
              ),
            ),
            const SizedBox(height: 34),

            Default.Button(
              onPressed: _planMyVisit,
              child: lang.planMyVisit,
              width: double.infinity,
              height: 44,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
