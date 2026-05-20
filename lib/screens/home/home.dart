import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/home/service.dart';
import 'package:flutter_application_1/screens/home/widget.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key, required this.user});

  AppUser user;

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  List<Place> places = [];

  fetchFeaturedPlaces() async {
    final res = await fetchFeaturedPlacesFromDB(city: widget.user.city);

    setState(() {
      places = res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFeaturedPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    double height = MediaQuery.sizeOf(context).height,
        width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(
              width: width,
              height: height,
              lang: lang,
              name: widget.user.firstName,
            ),

            SizedBox(height: height * .03),

            SizedBox(
              height: height * .05,
              width: width,
              child: categories(
                context: context,
                height: height,
                width: width,
                lang: lang,
              ),
            ),

            SizedBox(height: height * .03),

            Container(
              margin: EdgeInsets.only(left: width * .06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.featuredplaces,
                    style: TextStyle(
                      fontFamily: "Serif",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Default.textColor,
                    ),
                  ),
                  Text(
                    lang.handpickedplaces,
                    style: TextStyle(
                      fontFamily: "Sans-Serif",
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: Default.textColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * .03),

            Container(
              margin: EdgeInsets.only(left: width * .03),
              height: height * .4,
              width: width,
              child: featuredPlaces(
                places: places,
                context: context,
                height: height,
                width: width,
                lang: lang,
              ),
            ),

            SizedBox(height: height * .05),
          ],
        ),
      ),
    );
  }
}
