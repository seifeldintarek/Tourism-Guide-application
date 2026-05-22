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
  ValueNotifier<String> query = ValueNotifier("");

  @override
  void dispose() {
    category.dispose();
    searchController.dispose();
    query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    final Map<String, String> categoryMap = {
      lang.heritage: "heritage",
      lang.spiritual: "spiritual",
      lang.nature: "nature",
      lang.food: "food",
    };

    List<String> items = categoryMap.keys.toList();

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * .08,
          vertical: height * .03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            SizedBox(height: height * .005),

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
                fontWeight: FontWeight.normal,
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
                          onPressed: () {
                            category.value = null;
                            query.value = "";
                            searchController.clear();
                          },
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
                            onChanged: (val) {
                              category.value = val;
                              query.value = "";
                              searchController.clear();
                            },
                            width: width,
                            hintFontSize: fontSize,
                            bodyFontSize: fontSize,
                            color: Colors.white,
                          )
                        : categoryMap[selectedCategory] == null
                        ? SizedBox()
                        : searchTextfield(
                            context,
                            height,
                            width,
                            searchController,
                            lang,
                            categoryMap[selectedCategory]!,
                            query,
                            buildPlaceCard,
                          ),
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
