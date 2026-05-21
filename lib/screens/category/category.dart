import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/category/service.dart';
import 'package:flutter_application_1/screens/category/widget.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/root/themes.dart';

class Category_Screen extends StatefulWidget {
  Category_Screen({super.key, required this.category});

  Category category;

  @override
  State<Category_Screen> createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Default.textColor),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .01),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                mainImage(context, widget.category.img, height),

                Positioned(
                  bottom: height * .02,
                  left: width * .02,
                  child: Text(
                    lang.getByKey(widget.category.name).toUpperCase(),
                    // widget.category.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Serif",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height * .03),

            Container(
              margin: EdgeInsets.only(bottom: height * .03),
              padding: EdgeInsets.symmetric(horizontal: width * .1),
              child: AutoSizeText(
                lang.getByKey(widget.category.quote),
                style: GoogleFonts.ebGaramond(
                  color: Color(0xFF4A4A46),
                  fontSize: 18,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: width * .05),
              height: height * .04,
              width: width * .15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Default.buttonColor,
              ),
              child: Center(
                child: Text(
                  lang.all,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: height * .02),

            FutureBuilder<List<Place>>(
              future: fetchCategoryPlaces(widget.category.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                return !snapshot.hasData || snapshot.data!.isEmpty
                    ? SizedBox.shrink()
                    : getCategoryPlaces(
                        context,
                        height,
                        width,
                        lang,
                        snapshot.data!,
                      );
              },
            ),

            SizedBox(height: height * .06),
          ],
        ),
      ),
    );
  }
}
