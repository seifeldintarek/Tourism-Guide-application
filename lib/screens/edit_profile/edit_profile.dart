import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/models/User.dart';
import 'package:flutter_application_1/screens/edit_profile/service.dart';
import 'package:flutter_application_1/screens/signup/service.dart';
import 'package:flutter_application_1/screens/signup/widget.dart';

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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // ── UI state ──────────────────────────────────────────────────────────────
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSaving = false;

  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Live user — updated after each successful service call.
  late AppUser _currentUser;

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

    final pwd = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    // Only validate password when the user typed in either field.
    if (pwd.isNotEmpty || confirm.isNotEmpty) {
      if (pwd.length < 6) {
        pwdErr = "Password must be at least 6 characters";
        valid = false;
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

      // 1. Update name if anything changed.
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

      // 2. Update password only when the user filled in the field.
      if (newPass.isNotEmpty) {
        final updated = await updateUserPassword(newPwd, _currentUser, context);
        if (updated != null) {
          _currentUser = updated;
          _passwordController.clear();
          _confirmPasswordController.clear();
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
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(
                      'assets/images/profile/anonymus.jpg',
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
                        onPressed: () {
                          // TODO: image picker
                        },
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
              errorText: _lastNameError, // ← direct, no wrapper needed
            ),
            SizedBox(height: height * 0.03),

            // ── Password ─────────────────────────────────────────────────────
            buildLabel(lang.password, 11),
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
            buildLabel(lang.manageSavedPlaces, 15),
            SizedBox(height: height * 0.02),

            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: savedPlaces.length,
            //   itemBuilder: (context, index) => buildPlaceCard(
            //     title: savedPlaces[index].title,
            //     category: savedPlaces[index].category,
            //     location: savedPlaces[index].location,
            //     imageUrl: savedPlaces[index].imageUrl,
            //     screenWidth: width,
            //     screenHeight: height,
            //     onDelete: () => _deletePlace(index),
            //   ),
            // ),
            SizedBox(height: height * 0.04),

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
                        child: CircularProgressIndicator(strokeWidth: 2),
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
                  onPressed: () async {
                    Navigator.pop(context);
                  },
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
