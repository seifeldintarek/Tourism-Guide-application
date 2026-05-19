import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/info/info.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'package:flutter_application_1/screens/search/search.dart';
import 'package:flutter_application_1/screens/settings/hamburger.dart';

class Footer extends StatefulWidget {
  const Footer({super.key, required this.user});

  final AppUser user;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int index = 0;

  final List<Widget> screens = [
    Container(),
    const Search_Screen(),
    Container(),
    Profile(user: widget.user),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Color(0xFF463427))),
      drawer: Hamburger(),

      body: screens[index],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // Selected icon background
          indicatorColor: Colors.brown.shade800,

          // Icon colors (selected / unselected)
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.black);
          }),
        ),

        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),

          backgroundColor: Default.backgroundColor,
          elevation: 0,
          height: height * 0.1,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
