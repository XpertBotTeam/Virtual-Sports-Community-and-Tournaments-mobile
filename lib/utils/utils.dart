import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// converting image from base64 (string representation of the image stored in the db) to a byte 
// value (Uint8List) so that the image can be visualized using MemoryImage() widget.
Uint8List fromBase64ToByte(String base64Image) {
  List<int> bytes = base64Decode(base64Image);
  return Uint8List.fromList(bytes);
} 


// allowing user to pick image from gallery, and returning it as a base64 string
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