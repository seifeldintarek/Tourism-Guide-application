import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/edit_profile/edit_profile.dart';
import 'widget.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Profile extends StatefulWidget {
  Profile({super.key, required this.user});

  AppUser user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.id)
          .snapshots(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(body: Center(child: Text(lang.nodatafound)));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        widget.user = AppUser.fromMap(data);

        return Scaffold(
          backgroundColor: Default.backgroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Default.buttonColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(user: widget.user),
                    ),
                  );
                },
              ),
            ],
            leading: IconButton(
              icon: Icon(Icons.menu, color: Default.buttonColor),
              onPressed: () {},
            ),
            centerTitle: true,
          ),

          body: ScrollConfiguration(
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
                          color: NudePalette.nudeUser,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.07),

                      Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.02),

                            Text(
                              lang.visited,
                              style: TextStyle(
                                fontSize: 16,
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
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              "assets/images/profile/anonymus.jpg",
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        AutoSizeText(
                          widget.user.fullName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                            color: NudePalette.nudeDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: height * 0.005),

                        Text(
                          '${lang.explorer} • Cairo',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Times New Roman',
                            color: NudePalette.nudeBrown,
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * 0.1),

                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(
                                '42',
                                lang.visited,
                                height * 0.003,
                              ),

                              Container(
                                height: height * 0.03,
                                width: width * 0.004,
                                color: Colors.grey.withOpacity(0.3),
                              ),

                              buildStatColumn(
                                '128',
                                lang.saved,
                                height * 0.003,
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
          ),
        );
      },
    );
  }
}
