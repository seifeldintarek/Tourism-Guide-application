import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/default.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Widget labelText(String text) {
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

Widget buildLabel(String text, double labelFontSize) => Text(
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
  required double width,
  required double height,
  required double hintFontSize,
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

Widget customTextField({
  required TextEditingController controller,
  required String hint,
  bool isPassword = false,
  String? errorText,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF2EDE6),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
      errorText: errorText,
      errorStyle: const TextStyle(fontSize: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}

Widget buildPlaceCard({
  required String title,
  required String category,
  required String location,
  required String imageUrl,
  required double screenWidth,
  required double screenHeight,
  VoidCallback? onDelete,
}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
    ),
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.025),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: screenWidth * 0.06,
            ),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: screenWidth * 0.02),
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: Image.network(
              imageUrl,
              width: screenWidth * 0.16,
              height: screenWidth * 0.16,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  '$category • $location',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey[600],
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<String?> captureORselect(BuildContext context, String uid) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: const Text('Choose Image Source'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () async {
              final path = await captureImageFromCamera();
              if (ctx.mounted) Navigator.of(ctx).pop(path);
            },
            child: const Text('Capture'),
          ),
          TextButton(
            onPressed: () async {
              final path = await selectImageFromGallery();
              if (ctx.mounted) Navigator.of(ctx).pop(path);
            },
            child: const Text('Select'),
          ),
        ],
      );
    },
  );
}

Future<String?> selectImageFromGallery() async {
  if (await Permission.photos.request().isDenied) {
    openAppSettings();
  }
  final picker = ImagePicker();
  final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
  return picked?.path;
}

Future<String?> captureImageFromCamera() async {
  final picker = ImagePicker();
  final XFile? captured = await picker.pickImage(source: ImageSource.camera);
  return captured?.path;
}
