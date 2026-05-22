import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/screens/login/login.dart';
import 'package:flutter_application_1/screens/signup/widget.dart';
import 'package:flutter_application_1/screens/signup/service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _isAccepted = false;

  final Map<String, String> languages = {
    "English": "en",
    "Arabic": "ar",
    "Spanish": "es",
    "French": "fr",
    "German": "de",
  };

  String? _selectedLanguage;
  String? _selectedGovernorate;

  @override
  void initState() {
    super.initState();

    _selectedLanguage = languages.keys.first;

    void refreshUI() {
      setState(() {
        _emailError = null;
        _passwordError = null;
        _confirmPasswordError = null;
      });
    }

    _firstNameController.addListener(refreshUI);
    _lastNameController.addListener(refreshUI);
    _emailController.addListener(refreshUI);
    _passwordController.addListener(refreshUI);
    _confirmPasswordController.addListener(refreshUI);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void handleCreateAccount(AppLocalizations lang) async {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(password);

    setState(() {
      _emailError =
          RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          ).hasMatch(_emailController.text)
          ? null
          : "Invalid email format";

      if (password.length < 8) {
        _passwordError = lang.password8charserror;
      } else if (!hasUpper) {
        _passwordError = lang.passwordcapitalerror;
      } else if (!hasLower) {
        _passwordError = lang.passwordsmallerror;
      } else if (!hasDigit) {
        _passwordError = lang.passwordnumbererror;
      } else if (!hasSpecial) {
        _passwordError = lang.passwordspecialcharerror;
      } else {
        _passwordError = null;
      }

      _confirmPasswordError = password != confirmPassword
          ? "Passwords do not match"
          : null;
    });

    if (_emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    final success = await storeUser({
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "city": _selectedGovernorate,
      "language": languages[_selectedLanguage],
    }, context);

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(lang.failtostoreuser)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final List<String> egyptGovernorates = [
      lang.cairo,
      lang.giza,
      lang.alexandria,
      lang.dakahlia,
      lang.redSea,
      lang.beheira,
      lang.fayoum,
      lang.gharbia,
      lang.ismailia,
      lang.menofia,
      lang.minya,
      lang.qalyubia,
      lang.newValley,
      lang.suez,
      lang.aswan,
      lang.assiut,
      lang.beniSuef,
      lang.portSaid,
      lang.damietta,
      lang.sharkia,
      lang.southSinai,
      lang.kafrElSheikh,
      lang.matrouh,
      lang.luxor,
      lang.qena,
      lang.northSinai,
      lang.sohag,
    ];

    _selectedGovernorate ??= egyptGovernorates[0];

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double hPadding = width * 0.05;
    final double sectionGap = height * 0.025;
    final double smallGap = height * 0.01;

    final double titleFontSize = width * 0.08;
    final double labelFontSize = width * 0.028;
    final double bodyFontSize = width * 0.032;
    final double hintFontSize = width * 0.031;

    bool allFieldsFilled =
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _selectedLanguage != null &&
        _selectedGovernorate != null;

    bool hasNoErrors =
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;

    bool isButtonEnabled = allFieldsFilled && hasNoErrors && _isAccepted;

    Widget buildLabel(String text) => Text(
      text,
      style: TextStyle(
        fontSize: labelFontSize,
        fontWeight: FontWeight.w600,
        color: Default.textColor,
        letterSpacing: 0.5,
      ),
    );

    InputDecoration buildInputDecoration({
      required String hint,
      String? errorText,
      Widget? suffixIcon,
    }) => InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey, fontSize: hintFontSize),
      errorText: errorText,
      errorStyle: TextStyle(fontSize: hintFontSize * 0.9),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.018,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );

    return Scaffold(
      backgroundColor: Default.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Default.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.tellUsAboutYourself,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Default.textColor,
                ),
              ),

              SizedBox(height: smallGap),

              Container(
                width: 40,
                height: 1,
                decoration: BoxDecoration(
                  color: const Color(0xFF463427),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              SizedBox(height: sectionGap * 2),

              Row(
                children: [
                  Expanded(child: buildLabel(lang.firstName.toUpperCase())),
                  SizedBox(width: width * 0.025),
                  Expanded(child: buildLabel(lang.lastName.toUpperCase())),
                ],
              ),

              SizedBox(height: smallGap),

              Row(
                children: [
                  Expanded(
                    child: customTextField(
                      controller: _firstNameController,
                      hint: lang.firstNameHint,
                    ),
                  ),
                  SizedBox(width: width * 0.025),
                  Expanded(
                    child: customTextField(
                      controller: _lastNameController,
                      hint: lang.lastNameHint,
                    ),
                  ),
                ],
              ),

              SizedBox(height: sectionGap),

              buildLabel(lang.emailAddress.toUpperCase()),
              SizedBox(height: smallGap),

              TextField(
                controller: _emailController,
                decoration: buildInputDecoration(
                  hint: lang.emailHint,
                  errorText: _emailError,
                ),
              ),

              SizedBox(height: sectionGap),

              buildLabel(lang.createPassword.toUpperCase()),
              SizedBox(height: smallGap),

              TextField(
                controller: _passwordController,
                onChanged: (val) => setState(() {}),
                obscureText: _obscurePassword,
                decoration: buildInputDecoration(
                  hint: lang.enterPassword,
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: sectionGap),

              buildLabel(lang.confirmPassword.toUpperCase()),
              SizedBox(height: smallGap),

              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: buildInputDecoration(
                  hint: lang.confirmPassword,
                  errorText: _confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: sectionGap),

              Row(
                children: [
                  Expanded(child: buildLabel(lang.language.toUpperCase())),
                  SizedBox(width: width * 0.025),
                  Expanded(child: buildLabel(lang.government)),
                ],
              ),

              SizedBox(height: smallGap),

              Row(
                children: [
                  Expanded(
                    child: buildDropdown(
                      value: _selectedLanguage,
                      hint: lang.selectlang,
                      items: languages.keys.toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedLanguage = val;
                        });
                      },
                      bodyFontSize: bodyFontSize,
                      hintFontSize: hintFontSize,
                      width: width,
                      color: const Color(0xFFF2EDE6),
                    ),
                  ),

                  SizedBox(width: width * 0.025),

                  Expanded(
                    child: buildDropdown(
                      value: _selectedGovernorate,
                      hint: lang.selectgov,
                      items: egyptGovernorates,
                      onChanged: (val) {
                        setState(() {
                          _selectedGovernorate = val;
                        });
                      },
                      bodyFontSize: bodyFontSize,
                      hintFontSize: hintFontSize,
                      width: width,
                      color: const Color(0xFFF2EDE6),
                    ),
                  ),
                ],
              ),

              SizedBox(height: sectionGap),

              CheckboxListTile(
                value: _isAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    _isAccepted = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF463427),
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF4E453E),
                      fontSize: bodyFontSize,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: lang.agreeToTermsPrefix),
                      TextSpan(
                        text: lang.termsOfService,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: lang.and),
                      TextSpan(
                        text: lang.privacyPolicy,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: sectionGap * 1.5),

              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Default.Button(
                    onPressed: isButtonEnabled
                        ? () => handleCreateAccount(lang)
                        : null,
                    child: lang.createAccount,
                    width: width * 0.9,
                    height: height * 0.07,
                  ),
                ),
              ),

              SizedBox(height: sectionGap),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lang.alreadyAMember,
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      color: const Color(0xFF4E453E),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      " ${lang.signIn}",
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        color: const Color(0xFF4E453E),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: sectionGap),
            ],
          ),
        ),
      ),
    );
  }
}
