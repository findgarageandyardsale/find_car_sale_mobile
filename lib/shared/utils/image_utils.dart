// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static bool isImage({required String path}) {
    final mimeType = lookupMimeType(path) ?? '';

    return mimeType.startsWith('image/');
  }

  static bool isImages(String url) {
    return url.contains('jpg') ||
            url.contains('jpeg') ||
            url.contains('png') ||
            url.contains('ico') ||
            url.contains('webp') ||
            url.contains('gif')
        ? true
        : false;
  }

  static IconData checkIcon(String name) {
    final extension = name.split('.').last;
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;

      case 'pdf':
        return Icons.picture_as_pdf;

      case 'doc':
      case 'docx':
        return Icons.insert_drive_file_rounded;

      case 'mp3':
        return Icons.audio_file;

      case 'mp4':
        return Icons.video_file;
      default:
        return Icons.file_copy;
    }
  }

  static Future<File> compressImage(String path,
      {int quality = 10, bool? isActuallyImage}) async {
    try {
      //check whether the file is image or not
      final isThisPathImage = isActuallyImage ?? isImage(path: path);

      if (isThisPathImage) {

        ///[check if the image contain .heic image]
          var dir = await getApplicationSupportDirectory();
          final target =
              '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
          XFile? compressedXFile =
              await FlutterImageCompress.compressAndGetFile(path, target,
                  quality: quality, keepExif: true);
          File? compressedFile =
              compressedXFile == null ? null : File(compressedXFile.path);

          return compressedFile ?? File(path);
        } else {
          return File(path);
        }
    } catch (_) {
      return File(path);
    }
  }

  static Future<bool> isFileGreatherThan25mb({required String path}) async {
    final file = File(path);
    return (await file.length() > 25000 * 1000);
  }
}
