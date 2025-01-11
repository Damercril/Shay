import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      if (kIsWeb) {
        // Handle web platform
        // For web, you might want to handle the XFile differently
        // as File operations work differently in web
        continue;
      } else {
        images.add(File(image.path));
      }
    }
  }
  
  return images;
}
