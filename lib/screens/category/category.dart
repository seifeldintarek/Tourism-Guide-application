import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/screens/category/widget.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

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
          children: [
            Stack(
              children: [
                mainImage(context, widget.category.img, height),
                Positioned(
                  bottom: height * .02,
                  left: width * .02,
                  child: Text(
                    widget.category.name.toUpperCase(),
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

            SizedBox(height: height * .1),

            // ListView.builder(itemBuilder: ())
            SizedBox(height: height * .3),

            Container(
              margin: EdgeInsets.only(bottom: height * .03),
              padding: EdgeInsets.symmetric(horizontal: width * .1),
              child: AutoSizeText(
                widget.category.quote,
                style: GoogleFonts.ebGaramond(
                  color: Color(0xFF4A4A46),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
