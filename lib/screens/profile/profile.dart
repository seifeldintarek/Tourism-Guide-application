import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'service.dart';
import 'widget.dart';

class Profile extends StatefulWidget {
  Profile({super.key, required this.user});
  AppUser user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedTab = 0; // 0 = Visited, 1 = Saved
  int _visitedCount = 0; // add this
  int _savedCount = 0;
  Widget _buildPlacesTab({
    required Stream<List<Place>> stream,
    required IconData emptyIcon,
    required String emptyMessage,
    required double height,
    bool isBookmarked = false,
    bool isVisitedTab = false,
  }) {
    return StreamBuilder<List<Place>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        final places = snapshot.data ?? [];

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_selectedTab == 0 && _visitedCount != places.length) {
            setState(() => _visitedCount = places.length);
          }
          if (_selectedTab == 1 && _savedCount != places.length) {
            setState(() => _savedCount = places.length);
          }
        });
        if (places.isEmpty) {
          return buildEmptyState(icon: emptyIcon, message: emptyMessage);
        }
        return buildPlacesList(
          context: context,
          places: places,
          height: height,
          isBookmarked: isBookmarked,
          id: widget.user.id,
          width: MediaQuery.of(context).size.width,
          isVisitedTab: isVisitedTab,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return StreamBuilder<AppUser>(
      stream: userStream(widget.user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text(lang.nodatafound)));
        }

        final user = snapshot.data!;

        return Scaffold(
          backgroundColor: Default.backgroundColor,
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
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.07),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tab bar
                            Row(
                              children: [
                                buildTabButton(
                                  label: lang.visited,
                                  isSelected: _selectedTab == 0,
                                  width: width,
                                  onTap: () => setState(() => _selectedTab = 0),
                                  height: height,
                                ),
                                SizedBox(width: width * 0.06),
                                buildTabButton(
                                  label: lang.saved,
                                  isSelected: _selectedTab == 1,
                                  width: width,
                                  onTap: () => setState(() => _selectedTab = 1),
                                  height: height,
                                ),
                              ],
                            ),

                            SizedBox(height: height * 0.02),

                            // Tab content
                            if (_selectedTab == 0)
                              _buildPlacesTab(
                                stream: visitedPlacesStream(user.id),
                                emptyIcon: Icons.explore_outlined,
                                emptyMessage: lang.novisitedplaces,
                                height: height,
                                isVisitedTab: true,
                              )
                            else
                              _buildPlacesTab(
                                stream: savedPlacesStream(user.id),
                                emptyIcon: Icons.bookmark_border,
                                emptyMessage: lang.nosavedplaces,
                                height: height,
                                isBookmarked: true,
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
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            child: ClipOval(
                              child:
                                  (user.profilePictureUrl != null &&
                                      user.profilePictureUrl!.isNotEmpty)
                                  ? CachedNetworkImage(
                                      imageUrl: user.profilePictureUrl!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (_, __, ___) => Image.asset(
                                        'assets/images/profile/anonymus.jpg',
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/profile/anonymus.jpg',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        AutoSizeText(
                          user.fullName,
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
                          '${lang.explorer} • ${widget.user.city}',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Times New Roman',
                            color: NudePalette.nudeBrown,
                          ),
                        ),

                        SizedBox(height: height * 0.05),

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
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(
                                _savedCount.toString(),
                                lang.saved,
                                height * 0.003,
                              ),
                              Container(
                                height: height * 0.03,
                                width: width * 0.004,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              buildStatColumn(
                                _visitedCount.toString(),
                                lang.visited,
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
