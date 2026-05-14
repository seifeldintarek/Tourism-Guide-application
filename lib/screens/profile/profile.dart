import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NudePalette.nudeLight,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color(0xFF3B2F2F)),
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
                    height: 335,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: NudePalette.nude,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saved Places',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman',
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: placesData.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final place = placesData[index];
                            return buildPlaceCard(
                              place['title'],
                              place['subtitle'],
                              place['color'],
                              place['img'],
                            );
                          },
                        ),
                        SizedBox(height: 50),
                        
                      ],
                    ),
                  ),
                ],
              ),
            Positioned(
              top: 50,
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
                  SizedBox(height: 16),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                      color: Color(0xFF3B2F2F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Explorer • Cairo',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                      color: Color(0xFF8A7D72),
                    ),
                  ),
                  const SizedBox(height: 24), // Add some space before the card
                  
                  // --- STATS CARD STARTS HERE ---
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24), // Keeps it from touching the screen edges
                    padding: const EdgeInsets.symmetric(vertical: 16), // Padding inside the card
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05), // A very soft shadow
                          blurRadius: 10,
                          offset: const Offset(0, 5), // Pushes the shadow down slightly
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildStatColumn('42', 'VISITED'),
                        Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                        buildStatColumn('128', 'SAVED'),
                        Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.3)),
                        buildStatColumn('15', 'REVIEWS'),
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
