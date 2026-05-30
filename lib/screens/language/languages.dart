import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'en';
  bool _seeded = false;

  final List<Map<String, String>> languages = [
    {"country": "Egypt", "language": "ar", "flag": "🇪🇬"},
    {"country": "UK", "language": "en", "flag": "🇬🇧"},
    {"country": "Spain", "language": "es", "flag": "🇪🇸"},
    {"country": "France", "language": "fr", "flag": "🇫🇷"},
    {"country": "Germany", "language": "de", "flag": "🇩🇪"},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Seed the highlighted card from the actual current locale, once.
    if (!_seeded) {
      selectedLanguage = Localizations.localeOf(context).languageCode;
      _seeded = true;
    }
  }

  Future<void> _selectLanguage(String code) async {
    setState(() => selectedLanguage = code);

    // 1. Update the running app immediately.
    context.read<LocaleProvider>().setLocale(Locale(code));

    // 2. Persist to cache (offline fallback / source for initializeApp's
    //    catch branch).
    await AppUser.updateCachedLanguage(code);

    // 3. Persist to Firestore (source of truth on next launch).
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'language': code});
      } catch (e) {
        debugPrint('Failed to persist language to Firestore: $e');
        // Cache still holds it, so it survives a restart even if this fails.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double hPadding = width * 0.05;
    final double sectionGap = height * 0.025;
    final double smallGap = height * 0.01;

    final double titleFontSize = width * 0.08;
    final double labelFontSize = width * 0.028;
    final double bodyFontSize = width * 0.032;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: smallGap),

              // Top Bar
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF463427),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        lang.language,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF463427),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              SizedBox(height: sectionGap * 1.6),

              Center(
                child: Text(
                  lang.preferenceSelection,
                  style: TextStyle(
                    letterSpacing: 4,
                    fontSize: labelFontSize,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: sectionGap),

              Center(
                child: Text(
                  lang.curateYourExperience,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF463427),
                  ),
                ),
              ),

              SizedBox(height: smallGap * 2),

              Center(
                child: Container(
                  width: width * 0.175,
                  height: 2,
                  color: const Color(0xFFD8CFC5),
                ),
              ),

              SizedBox(height: sectionGap * 1.6),

              // Language Cards
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final item = languages[index];
                    final bool isSelected =
                        selectedLanguage == item["language"];

                    return GestureDetector(
                      onTap: () => _selectLanguage(item["language"]!),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.only(bottom: height * 0.022),
                        padding: EdgeInsets.symmetric(
                          horizontal: hPadding,
                          vertical: height * 0.027,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EEE8),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF463427)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              item["flag"]!,
                              style: TextStyle(fontSize: width * 0.085),
                            ),
                            SizedBox(width: width * 0.045),
                            Text(
                              item["country"]!,
                              style: TextStyle(
                                fontSize: bodyFontSize * 1.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: height * 0.072,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF463427),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    lang.continueButton,
                    style: TextStyle(
                      fontSize: bodyFontSize * 1.4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: sectionGap),
            ],
          ),
        ),
      ),
    );
  }
}