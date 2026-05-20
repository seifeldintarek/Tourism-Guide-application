import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/category/category.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Category_Screen()),
          ),
          child: Text("go"),
        ),
      ),
    );
  }
}
