import 'package:flutter/material.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
      ],
      home: const Login(),
    );
  }
}
