import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/profile/service.dart'; // savedPlacesStream lives here
import 'widget.dart';
import 'package:flutter_application_1/screens/saved_screen/skeleton.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final AppUser? user = await AppUser.loadFromCache();
    if (mounted) {
      setState(() => _userId = user?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    final double hPadding = width * 0.05;
    final double sectionGap = height * 0.025;
    final double smallGap = height * 0.01;
    final double titleFontSize = width * 0.08;
    final double labelFontSize = width * 0.028;
    final double bodyFontSize = width * 0.032;
    final double thumbSize = width * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: smallGap),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              child: Text(
                lang.savedPlaces,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(height: sectionGap),
            Expanded(
              child: _userId == null
                  ? const SavedPlacesSkeletonList()
                  : StreamBuilder<List<Place>>(
                      stream: savedPlacesStream(_userId!),
                      builder: (context, snapshot) {
                        // Loading
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SavedPlacesSkeletonList();
                        }

                        // Error
                        if (snapshot.hasError) {
                          return ErrorPlacesView(
                            bodyFontSize: bodyFontSize,
                            onRetry: _loadUser,
                          );
                        }

                        final List<Place> places = snapshot.data ?? [];

                        // Empty
                        if (places.isEmpty) {
                          return EmptyPlacesView(
                            bodyFontSize: bodyFontSize,
                            labelFontSize: labelFontSize,
                          );
                        }

                        // List
                        return ListView.separated(
                          padding:
                              EdgeInsets.symmetric(horizontal: hPadding),
                          itemCount: places.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(height: smallGap * 1.2),
                          itemBuilder: (context, index) => PlaceCard(
                            place: places[index],
                            thumbSize: thumbSize,
                            bodyFontSize: bodyFontSize,
                            labelFontSize: labelFontSize,
                            smallGap: smallGap,
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: sectionGap),
          ],
        ),
      ),
    );
  }
}