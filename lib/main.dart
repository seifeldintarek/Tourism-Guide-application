import 'package:flutter/material.dart';
import 'package:flutter_application_1/root/app_root.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRoot();
  }
}
