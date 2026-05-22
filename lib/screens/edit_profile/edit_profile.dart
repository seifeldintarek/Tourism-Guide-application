import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/root/themes.dart';
import 'package:flutter_application_1/screens/edit_profile/service.dart';
import 'package:flutter_application_1/screens/edit_profile/widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});

  final AppUser user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  bool _isSaving = false;

  String? _firstNameError;
  String? _lastNameError;

  late AppUser _currentUser;

  dynamic _avatarSource;
  File? _pendingImageFile;
  int _cacheVersion = 0;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _resolveAvatar();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _resolveAvatar() async {
    final liveUrl = _currentUser.profilePictureUrl ?? '';
    if (liveUrl.isNotEmpty) {
      setState(() => _avatarSource = liveUrl);
      return;
    }

    final cached = await AppUser.loadFromCache();
    final cachedUrl = cached?.profilePictureUrl ?? '';
    if (cachedUrl.isNotEmpty) {
      _currentUser.profilePictureUrl = cachedUrl;
      setState(() => _avatarSource = cachedUrl);
      return;
    }

    setState(() => _avatarSource = null);
  }

  Future<void> _pickPhoto() async {
    final path = await captureORselect(context, _currentUser.id);
    if (path == null || path.isEmpty) return;

    final file = File(path);
    setState(() {
      _pendingImageFile = file;
      _avatarSource = file;
    });
  }

  bool _validate() {
    bool valid = true;
    String? firstErr;
    String? lastErr;

    if (_firstNameController.text.trim().isEmpty) {
      firstErr = 'First name cannot be empty';
      valid = false;
    }

    if (_lastNameController.text.trim().isEmpty) {
      lastErr = 'Last name cannot be empty';
      valid = false;
    }

    setState(() {
      _firstNameError = firstErr;
      _lastNameError = lastErr;
    });

    return valid;
  }

  Future<void> _save() async {
    if (!_validate()) return;

    setState(() => _isSaving = true);

    try {
      final newFirst = _firstNameController.text.trim();
      final newLast = _lastNameController.text.trim();

      if (_pendingImageFile != null) {
        final uploadedUrl = await uploadImage(
          imageFile: _pendingImageFile!,
          user: _currentUser,
          context: context,
        );

        if (uploadedUrl != null) {
          _currentUser.profilePictureUrl = uploadedUrl;
          await _currentUser.saveToCache();
          await updateProfilePictureUrl(uploadedUrl, _currentUser, context);

          setState(() {
            _avatarSource = uploadedUrl;
            _pendingImageFile = null;
            _cacheVersion++;
          });
        }
      }

      final nameChanged =
          newFirst != _currentUser.firstName ||
          newLast != _currentUser.lastName;
      if (nameChanged) {
        final updated = await updateUserFullName(
          newFirst,
          newLast,
          _currentUser,
          context,
        );
        if (updated != null) _currentUser = updated;
      }

      if (mounted) {
        Default.appMsg(context, 'Profile updated successfully.');
        Navigator.pop(context, _currentUser);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        title: Text(
          lang.editProfileTitle,
          style: TextStyle(
            color: Default.textColor,
            fontFamily: 'Times New Roman',
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: ListView(
          children: [
            SizedBox(height: height * 0.04),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: _avatarSource is File
                          ? Image.file(
                              _avatarSource as File,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            )
                          : (_avatarSource is String &&
                                (_avatarSource as String).isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl:
                                  (_avatarSource as String).contains(
                                    'supabase.co',
                                  )
                                  ? '${_avatarSource}?v=$_cacheVersion'
                                  : _avatarSource as String,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/profile/anonymus.jpg',
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/profile/anonymus.jpg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Default.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: _pickPhoto,
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Center(
              child: Text(
                lang.changePhoto,
                style: TextStyle(
                  color: Default.textColor,
                  fontFamily: 'Arial',
                  fontSize: width * 0.03,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),

            buildLabel(lang.firstNameHint, width * 0.03),
            SizedBox(height: height * 0.01),
            customTextField(
              controller: _firstNameController,
              hint: lang.firstNameHint,
              errorText: _firstNameError,
            ),
            SizedBox(height: height * 0.03),

            buildLabel(lang.lastNameHint, width * 0.03),
            SizedBox(height: height * 0.01),
            customTextField(
              controller: _lastNameController,
              hint: lang.lastNameHint,
              errorText: _lastNameError,
            ),
            SizedBox(height: height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildLabel(lang.manageSavedPlaces, width * 0.04),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    lang.editSaved,
                    style: TextStyle(
                      color: Default.buttonColor,
                      fontSize: width * 0.028,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),

            StreamBuilder<List<Place>>(
              stream: savedPlacesStream(_currentUser.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final places = snapshot.data ?? [];

                if (places.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: Center(
                      child: Text(
                        lang.nosavedplaces,
                        style: TextStyle(
                          color: NudePalette.nudeBrown,
                          fontFamily: 'Times New Roman',
                          fontSize: width * 0.033,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: places.length,
                  separatorBuilder: (_, __) => SizedBox(height: height * 0.01),
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return buildPlaceCard(
                      title: lang.getByKey(place.name),
                      category: place.category.toUpperCase(),
                      location: lang.getByKey(place.city),
                      imageUrl: place.mainImage,
                      screenWidth: width,
                      screenHeight: height,
                      onDelete: () async {
                        await deleteSavedPlace(_currentUser.id, place.id);
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: height * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isSaving)
                  SizedBox(
                    width: height * 0.03,
                    height: height * 0.03,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Default.Button(
                    child: lang.saveChanges,
                    onPressed: _save,
                    width: width * 0.23,
                    height: height * 0.06,
                  ),

                SizedBox(width: width * .04),
                Default.Button(
                  buttonColor: Colors.white,
                  textColor: Default.buttonColor,
                  child: lang.cancel,
                  onPressed: () => Navigator.pop(context),
                  width: width * 0.35,
                  height: height * 0.06,
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
