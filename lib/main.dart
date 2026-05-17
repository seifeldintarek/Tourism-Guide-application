import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/root/app_root.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("firebase initialized successfully");

  await Supabase.initialize(
    url: "https://prfwmjmedmfqauccmqgv.supabase.co/rest/v1/",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InByZndtam1lZG1mcWF1Y2NtcWd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg1MTMzMzYsImV4cCI6MjA5NDA4OTMzNn0.jsjwvtfHm1lJTmCzfU5veQIowdNSqy7jufdxmwcdIxU",
  );
  print("supabase initialized successfully");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LocaleProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRoot();
  }
}

//CANCEL BUTTON
