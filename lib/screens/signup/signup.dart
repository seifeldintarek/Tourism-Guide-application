import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/profile/profile.dart';
import 'package:flutter_application_1/screens/signup/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Separate controllers for every field
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

  String? _selectedLanguage;
  String? _selectedCurrency;

  final List<String> languages = [
    "English",
    "Arabic",
    "Spanish",
    "French",
    "German",
  ];
  final List<String> currencies = ["USD", "EUR", "EGP", "SAR", "AED"];

  bool _isAccepted = false;
  @override
  void initState() {
    super.initState();

    // Create a listener function that triggers a UI rebuild
    void refreshUI() {
      setState(() {
        _emailError = null;
        _passwordError = null;
        _confirmPasswordError = null;
      });
    }

    // Attach the listener to all your text controllers
    _firstNameController.addListener(refreshUI);
    _lastNameController.addListener(refreshUI);
    _emailController.addListener(refreshUI);
    _passwordController.addListener(refreshUI);
    _confirmPasswordController.addListener(refreshUI);
  }

  @override
  void dispose() {
    // Always clean up controllers when the widget is removed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void handleCreateAccount() {
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

      // Password Complexity Validation
      if (password.length < 8) {
        _passwordError = "Password must be at least 8 characters";
      } else if (!hasUpper) {
        _passwordError = "Add at least one capital letter";
      } else if (!hasLower) {
        _passwordError = "Add at least one small letter";
      } else if (!hasDigit) {
        _passwordError = "Add at least one number";
      } else if (!hasSpecial) {
        _passwordError = "Add at least one special character";
      } else {
        _passwordError = null;
      }

      // Matching Validation
      if (password != confirmPassword) {
        _confirmPasswordError = "Passwords do not match";
      } else {
        _confirmPasswordError = null;
      }
    });

    if (_emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      print("All validations passed!");
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(), //when a profile screen is created
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool allFieldsFilled =
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _selectedLanguage != null &&
        _selectedCurrency != null;

    bool hasNoErrors =
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;

    bool isButtonEnabled = allFieldsFilled && hasNoErrors && _isAccepted;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFEF9F4),
        title: Row(
          children: [
            const Icon(Icons.arrow_back, size: 18, color: Color(0xFF463427)),
            const SizedBox(width: 10),
            const Text(
              "Join the Archive",
              style: TextStyle(color: Color(0xFF463427), fontSize: 18),
            ),
            const SizedBox(width: 15),

            // Custom small horizontal line
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tell us about \nyourself",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF463427),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 1,
                decoration: BoxDecoration(
                  color: const Color(0xFF463427),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 50),

              // NAME SECTION
              const Row(
                children: [
                  Expanded(child: _LabelText("FIRST NAME")),
                  SizedBox(width: 10),
                  Expanded(child: _LabelText("LAST NAME")),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _CustomTextField(
                      controller: _firstNameController,
                      hint: "Enter first name",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CustomTextField(
                      controller: _lastNameController,
                      hint: "Enter last name",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const _LabelText("EMAIL ADDRESS"),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF2EDE6),
                  hintText: "Enter your email",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  errorText: _emailError, // Added error display
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const _LabelText("CREATE PASSWORD"),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                onChanged: (val) => setState(() {}),
                obscureText: _obscurePassword, // Toggle applied here
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF2EDE6),
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  errorText: _passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const _LabelText("CONFIRM PASSWORD"),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword, // Toggle applied here
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF2EDE6),
                  hintText: "Confirm your password",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  errorText: _confirmPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Row(
                children: [
                  Expanded(child: _LabelText("LANGUAGE")),
                  SizedBox(width: 10),
                  Expanded(child: _LabelText("CURRENCY")),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _CustomDropdown(
                      value: _selectedLanguage,
                      hint: "Select Language",
                      items: languages,
                      onChanged: (val) =>
                          setState(() => _selectedLanguage = val),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CustomDropdown(
                      value: _selectedCurrency,
                      hint: "Select Currency",
                      items: currencies,
                      onChanged: (val) =>
                          setState(() => _selectedCurrency = val),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              CheckboxListTile(
                value: _isAccepted,
                onChanged: (bool? value) =>
                    setState(() => _isAccepted = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF463427),
                title: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color(0xFF4E453E),
                      fontSize: 13,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: "By creating an account, I agree to the "),
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? handleCreateAccount : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF463427),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?", // Remove the trailing space here if there is one
                    style: TextStyle(fontSize: 14, color: Color(0xFF4E453E)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // 1. Removes internal padding
                      minimumSize:
                          Size.zero, // 2. Removes the default width/height
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // 3. Tightens the hit box
                    ),
                    child: const Text(
                      " Sign in", // Add exactly one space here for a natural look
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4E453E),
                        fontWeight: FontWeight.bold,
                        decoration:
                            TextDecoration.underline, // Matches the image style
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Home(), //when a profile screen is created
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String text;
  const _LabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4E453E),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  const _CustomTextField({
    required this.controller,
    required this.hint,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2EDE6),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;

  const _CustomDropdown({
    this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: const TextStyle(fontSize: 14)),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2EDE6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(i)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
