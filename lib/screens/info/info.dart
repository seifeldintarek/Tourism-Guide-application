import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'widget.dart';

class Infoscreen extends StatefulWidget {
  const Infoscreen({super.key});

  @override
  State<Infoscreen> createState() => _InfoscreenState();
}

class _InfoscreenState extends State<Infoscreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: Default.archiveAppBar(
        context: context,
        title: 'THE ARCHIVE',
        trailingIcon: const Icon(
          Icons.bookmark_border,
          color: NudePalette.nudeBrown,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainImageHeader(),
            const SizedBox(height: 24),

            const Text(
              'Egyptian\nMuseum',
              style: TextStyle(
                fontFamily: 'NotoSerif',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1C18),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                const Text(
                  '4.8',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                  ),
                ),
                Text(
                  ' (12.4k)',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Row(
              children: [
                TagChip(label: 'Historical'),
                TagChip(label: 'Artifacts'),
                TagChip(label: 'Landmark'),
              ],
            ),
            const SizedBox(height: 24),

            // --- 1. About Box (Now FIRST) ---
            InfoBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Default.sectionTitle('About'),
                  const SizedBox(height: 12),
                  const Text(
                    'Ancient Egyptian artifacts collection with over 120,000 items.',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      height: 1.5,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 2. Status & Hours Box (Now SECOND) ---
            InfoBox(
              backgroundColor: NudePalette.nudeDark,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATUS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      Text(
                        'Open',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSerif',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'HOURS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      Text(
                        '9-5',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSerif',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 3. Starting Price Box (Now THIRD) ---
            InfoBox(
              child: Row(
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
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STARTING',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      Text(
                        'EGP 200',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'NotoSerif',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Default.sectionTitle(
              'Gallery',
              trailing: const Text(
                '4 PHOTOS',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GalleryImage(imagePath: 'assets/images/gallery1.png'),
                  GalleryImage(imagePath: 'assets/images/gallery2.png'),
                  GalleryImage(imagePath: 'assets/images/gallery3.jpg'),
                  GalleryImage(imagePath: 'assets/images/gallery4.webp'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Center(
              child: Default.Button(
                onPressed: () {
                  Default.navigateToExternalUrl(
                    "https://egymonuments.com/book-date/3",
                  );
                },
                child: 'BOOK NOW',
                width: width * 0.85,
                height: height * 0.08,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
