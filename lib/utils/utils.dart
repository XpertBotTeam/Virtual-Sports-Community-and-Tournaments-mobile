import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Uint8List fromBase64ToByte(String base64Image) {
  List<int> bytes = base64Decode(base64Image);
  return Uint8List.fromList(bytes);
} 


Future<String?> pickGalleryImage(context) async {

  try {
    final ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
        Uint8List uint8list = await pickedFile.readAsBytes();
        return base64Encode(uint8list);
    } else {
      return null;
    }

  } catch(err) {
    print(err);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("An error occurred while picking the image."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    return null;
  }



}