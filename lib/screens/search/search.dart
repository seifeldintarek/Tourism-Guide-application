import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/search/widget.dart';
import 'package:flutter_application_1/screens/signup/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController searchController = TextEditingController();
  double fontSize = 14;
  ValueNotifier<String?> category = ValueNotifier(null);

  @override
  void dispose() {
    category.dispose(); // ✅ always dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    List<String> items = [
      lang.heritage,
      lang.spiritual,
      lang.nature,
      lang.food,
    ];

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * .1,
          vertical: height * .03,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              lang.curatedJourneys,
              style: TextStyle(
                fontFamily: "Sans-Serif",
                fontSize: 10,
                color: Default.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),

            Text(
              lang.exploreThe,
              style: TextStyle(
                fontFamily: "Serif",
                fontSize: 22,
                color: Default.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              lang.collections,
              style: GoogleFonts.cormorantGaramond(
                fontWeight: FontWeight.normal, // Light
                fontSize: 22,
                color: Default.textColor,
              ),
            ),

            SizedBox(height: height * .02),

            ValueListenableBuilder<String?>(
              valueListenable: category,
              builder: (context, selectedCategory, _) {
                return Column(
                  children: [
                    if (selectedCategory != null)
                      Center(
                        child: TextButton(
                          onPressed: () => category.value = null,
                          child: Text(
                            lang.changecategory,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,
                              fontFamily: "arial",
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                    selectedCategory == null
                        ? buildDropdown(
                            value: null,
                            hint: lang.choosecategory,
                            items: items,
                            onChanged: (val) => category.value = val,
                            width: width,
                            hintFontSize: fontSize,
                            bodyFontSize: fontSize,
                            color: Colors.white,
                          )
                        : searchTextfield(
                            context,
                            height,
                            width,
                            searchController,
                            lang,
                            selectedCategory.toLowerCase(),
                          ),

                    //here
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
