import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'widget.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
          height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Default.buttonColor),
          onPressed: () {},
        ),
       
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        // This single line disables the Android stretching effect completely
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.36,
                    width: width,
                    decoration: BoxDecoration(
                      color: NudePalette.nude,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.07),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: width * 0.05, right: width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.visited,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: placesData.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: height * 0.013),
                          itemBuilder: (context, index) {
                            final place = placesData[index];
                            return buildPlaceCard(
                              place['title'],
                              place['subtitle'],
                              place['img'],
                            );
                          },
                        ),
                        SizedBox(height: height * 0.07),
                        
                      ],
                    ),
                  ),
                ],
              ),
            Positioned(
              top: height * 0.06,
              left: 0,
              right: 0, 
              child: Column(
                children: [
                  // This Container creates the white border around the avatar
                  Container(
                    padding: const EdgeInsets.all(5), 
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/User Avatar.png"),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                      color: NudePalette.nudeDark,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    '${lang.explorer}  • Cairo',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                      color: NudePalette.nudeBrown,
                    ),
                  ),
                  SizedBox(height: 24), // Add some space before the card
                  
                  // --- STATS CARD STARTS HERE ---
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24), // Keeps it from touching the screen edges
                    padding: EdgeInsets.symmetric(vertical: 16), // Padding inside the card
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05), // A very soft shadow
                          blurRadius: 10,
                          offset: Offset(0, 5), // Pushes the shadow down slightly
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStatColumn('42', lang.visited),
                        Container(height: height * 0.03, width: width * 0.004, color: Colors.grey.withOpacity(0.3)),
                        buildStatColumn('128', lang.saved),
                      ],
                    ),
                  ),
                ],
              ),
              
            ),
            ],
          ),
        ),
      ),
    );
  }
}
