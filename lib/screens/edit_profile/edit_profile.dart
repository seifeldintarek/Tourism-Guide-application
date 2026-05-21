import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/edit_profile/service.dart';
import 'package:flutter_application_1/screens/signup/service.dart';
import 'package:flutter_application_1/screens/edit_profile/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/models/Place.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.user});

  final AppUser user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ── Controllers ───────────────────────────────────────────────────────────
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // ── UI state ──────────────────────────────────────────────────────────────
  bool _obscurePassword = true;
  bool _obscureOldPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSaving = false;

  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Live user — updated after each successful service call.
  late AppUser _currentUser;

  /// The resolved avatar source:
  ///   - [String]  → a remote URL (Supabase public URL)
  ///   - [File]    → a newly-picked local file (not yet uploaded)
  ///   - null      → show the bundled anonymous asset
  dynamic _avatarSource; // String | File | null

  /// Path of a newly-picked image that hasn't been saved yet.
  File? _pendingImageFile;

  // ── Lifecycle ─────────────────────────────────────────────────────────────
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
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Avatar resolution: Supabase → cache → anonymous ──────────────────────
  //
  // getPublicUrl() only constructs a URL string locally — it never does a
  // network request, so it always returns non-empty even when the file doesn't
  // exist in the bucket yet.  The actual proof that a file was uploaded is the
  // presence of a non-empty profilePictureUrl on the user record (written only
  // after a successful upload).  We use that as the gate.
  Future<void> _resolveAvatar() async {
    // 1. User object already carries a confirmed URL (set after an upload).
    final liveUrl = _currentUser.profilePictureUrl ?? '';
    if (liveUrl.isNotEmpty) {
      setState(() => _avatarSource = liveUrl);
      return;
    }

    // 2. Try the local cache — the user might have uploaded on another session.
    final cached = await AppUser.loadFromCache();
    final cachedUrl = cached?.profilePictureUrl ?? '';
    if (cachedUrl.isNotEmpty) {
      // Sync back onto the live object so we don't hit the cache next time.
      _currentUser.profilePictureUrl = cachedUrl;
      setState(() => _avatarSource = cachedUrl);
      return;
    }

    // 3. No picture has ever been uploaded — show the anonymous asset.
    setState(() => _avatarSource = null);
  }

  ImageProvider _buildAvatarProvider() {
    if (_avatarSource is File) {
      return FileImage(_avatarSource as File);
    }
    return const AssetImage('assets/images/profile/anonymus.jpg');
  }

  // ── Photo picker ──────────────────────────────────────────────────────────
  Future<void> _pickPhoto() async {
    final path = await captureORselect(context, _currentUser.id);
    if (path == null || path.isEmpty) return;

    final file = File(path);
    setState(() {
      _pendingImageFile = file;
      _avatarSource = file; // show preview immediately
    });
  }

  // ── Validation ────────────────────────────────────────────────────────────
  bool _validate() {
    bool valid = true;

    String? firstErr;
    String? lastErr;
    String? pwdErr;
    String? confirmErr;

    if (_firstNameController.text.trim().isEmpty) {
      firstErr = "First name cannot be empty";
      valid = false;
    }

    if (_lastNameController.text.trim().isEmpty) {
      lastErr = "Last name cannot be empty";
      valid = false;
    }

    if (_oldPasswordController.text.isNotEmpty) {
      final oldPass = hashPassword(_oldPasswordController.text);
      if (oldPass != widget.user.hashedPassword) {
        pwdErr = "Type your current password correctly to change it";
        valid = false;
      }
    }

    final pwd = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (pwd.isNotEmpty || confirm.isNotEmpty) {
      final hasUpper = RegExp(r'[A-Z]').hasMatch(pwd);
      final hasLower = RegExp(r'[a-z]').hasMatch(pwd);
      final hasDigit = RegExp(r'[0-9]').hasMatch(pwd);
      final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(pwd);

      if (pwd.length < 8) {
        pwdErr = "Password must be at least 8 characters";
      } else if (!hasUpper) {
        pwdErr = "Add at least one capital letter";
      } else if (!hasLower) {
        pwdErr = "Add at least one small letter";
      } else if (!hasDigit) {
        pwdErr = "Add at least one number";
      } else if (!hasSpecial) {
        pwdErr = "Add at least one special character";
      }

      if (pwd != confirm) {
        confirmErr = "Passwords do not match";
        valid = false;
      }
    }

    setState(() {
      _firstNameError = firstErr;
      _lastNameError = lastErr;
      _passwordError = pwdErr;
      _confirmPasswordError = confirmErr;
    });

    return valid;
  }

  // ── Save ──────────────────────────────────────────────────────────────────
  Future<void> _save() async {
    if (!_validate()) return;

    setState(() => _isSaving = true);

    try {
      final newFirst = _firstNameController.text.trim();
      final newLast = _lastNameController.text.trim();
      final newPass = _passwordController.text;
      final newPwd = hashPassword(newPass);

      // 1. Upload new profile picture if the user picked one.
      if (_pendingImageFile != null) {
        final uploadedUrl = await uploadImage(
          imageFile: _pendingImageFile!,
          user: _currentUser,
          context: context,
        );

        if (uploadedUrl != null) {
          // Persist the new URL on the live user object and in SharedPrefs.
          _currentUser.profilePictureUrl = uploadedUrl;
          await _currentUser.saveToCache();

          // Also update the Firestore document so other sessions see it.
          await updateProfilePictureUrl(uploadedUrl, _currentUser, context);

          setState(() {
            _avatarSource = uploadedUrl;
            _pendingImageFile = null;
          });
        }
      }

      // 2. Update name if anything changed.
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

      // 3. Update password only when the user filled in the field.
      if (newPass.isNotEmpty) {
        final updated = await updateUserPassword(newPwd, _currentUser, context);
        if (updated != null) {
          _currentUser = updated;
          _passwordController.clear();
          _confirmPasswordController.clear();
          _oldPasswordController.clear();
        }
      }

      if (mounted) {
        Default.appMsg(context, "Profile updated successfully.");
        Navigator.pop(context, _currentUser);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
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
            // ── Avatar ──────────────────────────────────────────────────────
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
                                  ? '${_avatarSource}?v=${DateTime.now().millisecondsSinceEpoch}'
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
                  fontSize: 12,
                ),
              ),
            ),

            SizedBox(height: height * 0.04),

            // ── First Name ───────────────────────────────────────────────────
            buildLabel(lang.firstNameHint, 11),
            SizedBox(height: height * 0.01),
            customTextField(
              controller: _firstNameController,
              hint: lang.firstNameHint,
              errorText: _firstNameError,
            ),
            SizedBox(height: height * 0.03),

            // ── Last Name ────────────────────────────────────────────────────
            buildLabel(lang.lastNameHint, 11),
            SizedBox(height: height * 0.01),
            customTextField(
              controller: _lastNameController,
              hint: lang.lastNameHint,
              errorText: _lastNameError,
            ),
            SizedBox(height: height * 0.03),

            // ── Old Password ─────────────────────────────────────────────────
            buildLabel(lang.currentpassword, 11),
            SizedBox(height: height * 0.01),
            passwordTextfield(
              _oldPasswordController,
              null,
              _obscureOldPassword,
              () => setState(() => _obscureOldPassword = !_obscureOldPassword),
              height,
              width,
              11,
            ),
            SizedBox(height: height * 0.03),

            // ── New Password ─────────────────────────────────────────────────
            buildLabel(lang.newpassword, 11),
            SizedBox(height: height * 0.01),
            passwordTextfield(
              _passwordController,
              _passwordError,
              _obscurePassword,
              () => setState(() => _obscurePassword = !_obscurePassword),
              height,
              width,
              11,
            ),
            SizedBox(height: height * 0.03),

            // ── Confirm Password ─────────────────────────────────────────────
            buildLabel(lang.confirmPassword, 11),
            SizedBox(height: height * 0.01),
            confirmPasswordTextfield(
              _confirmPasswordController,
              _confirmPasswordError,
              _obscureConfirmPassword,
              () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
              height,
              width,
              11,
            ),
            SizedBox(height: height * 0.03),

            // ── Manage Saved Places ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildLabel(lang.manageSavedPlaces, 15),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'EDIT SAVED',
                    style: TextStyle(
                      color: Default.buttonColor,
                      fontSize: 11,
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
                  return Center(child: CircularProgressIndicator());
                }

                final places = snapshot.data ?? [];

                if (places.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: Center(
                      child: Text(
                        "No saved places yet",
                        style: TextStyle(
                          color: NudePalette.nudeBrown,
                          fontFamily: 'Times New Roman',
                          fontSize: 13,
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
                      title: place.name,
                      category: place.category.toUpperCase(),
                      location: place.city.toUpperCase(),
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

            SizedBox(height: height * 0.02),

            // ── Action buttons ───────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_isSaving)
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.1),
                    child: Center(
                      child: SizedBox(
                        width: height * 0.03,
                        height: width * 0.03,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                else
                  Default.Button(
                    child: lang.saved.toString(),
                    onPressed: () async => await _save(),
                    width: width * 0.3,
                    height: height * .06,
                  ),

                Default.Button(
                  buttonColor: Colors.white,
                  textColor: Default.buttonColor,
                  child: lang.cancel.toString(),
                  onPressed: () => Navigator.pop(context),
                  width: width * 0.35,
                  height: height * .06,
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
