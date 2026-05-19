import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

Widget searchTextfield(
  BuildContext context,
  double height,
  double width,
  TextEditingController controller,
  AppLocalizations lang,
  String? category,
) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: width * .05),
    height: height * .06,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(80),
    ),
    child: TextField(
      controller: controller,
      cursorHeight: height * 0.022,
      decoration: InputDecoration(
        hintText: lang.searchDestination,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.travel_explore, color: Colors.grey.shade600),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: height * 0.018),
      ),
    ),
  );
}
