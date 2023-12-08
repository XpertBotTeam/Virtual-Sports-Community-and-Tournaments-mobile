import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// allowing user to pick image from gallery, duplicating it in the AppDocumentsDir,
// and then returning the path of the duplicated image (to be saved in the db)
Future<String?> pickAndDuplicateImage(context) async {
  try {
    // opening pick image menu for the user
    final ImagePicker imagePicker = ImagePicker();
    // storing selected image in a var called selectedImage
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    // if user did not pick an image, we return null
    if (selectedImage == null) {
      return null;
    }

    // transforming selectedImage from XFile to File for later operations
    final File selectedImageFile = File(selectedImage.path);

    // getting app documents dir, a local directory where the app can store
    // its documents in a safe place not accessible by users manually
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String docDir = appDocDir.path;
    // retrieving the baseName of the image file
    String fileName = path.basename(selectedImageFile.path);
    // creating a copy of the image in the app documents directory.
    final File newFile = await selectedImageFile.copy('$docDir/$fileName');
    return newFile.path;
  } catch (err) {
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
