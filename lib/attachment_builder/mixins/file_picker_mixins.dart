// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:findcarsale/shared/utils/image_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

///File picker mixin class
mixin CustomFilePickerMixin {
  /// pick files and returns [List<File>? files] - from which we can access files paths
  Future<List<File>?> getFiles({
    FileType type = FileType.any,
    bool? allowMultiple = true,
  }) async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple ?? false,
      onFileLoading: (status) {
        return const Center(child: CircularProgressIndicator());
      },
      // type: FileType.any
      type: type,
      allowedExtensions:
          type == FileType.custom
              ? ['doc', 'pdf', 'docx', 'xslx', 'docx', 'mp4', 'mp3', 'xlsx']
              : null,
    );
    List<File> files = [];
    if (result != null) {
      for (var e in result.paths) {
        final file = File(e!);
        if (await file.length() > 25000 * 1000) {
          CustomToast.showToast(
            'The file may not be greater than 25 MB.',
            status: ToastStatus.info,
          );
        } else {
          if (ImageUtils.isImage(path: e)) {
            final heicFormat = e.split('.').last.toLowerCase();

            if (heicFormat == 'heic' || heicFormat == 'hevc') {
              File compressedFile = await ImageUtils.compressImage(e);
              files.add(compressedFile);
            } else {
              files.add(file);
            }
          } else {
            files.add(file);
          }
        }
      }
      return files;
    } else {
      return null;
    }
  }

  void showMessageInDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void showD({BuildContext? context, String? title, required String message}) {
    if (context != null) {
      showMessageInDialog(
        context: context,
        title: title ?? '',
        message: message,
      );
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        openAppSettings(); // Close the dialog
      });
    }
  }

  // checks device permission, platform, file size and gets the Image
  Future<List<File>?> getCameraImageFiles({
    void Function()? isLoading,
    BuildContext? context,
  }) async {
    String guidelines = '''

To utilize this feature, please follow these steps to enable camera access on your device:

1. Access App Settings
2. Find App Permissions
3. Locate Camera Permission
4. Enable Camera Access
5. Return to App
''';

    try {
      await [Permission.camera, Permission.microphone].request();
      final result = await ImagePicker.platform.getImageFromSource(
        source: ImageSource.camera,
      );
      if (isLoading != null) isLoading();
      if (result == null) return null;
      var file = File(result.path);

      if (await file.length() > 25000 * 1000) {
        CustomToast.showToast(
          'The file may not be greater than 25 MB.',
          status: ToastStatus.info,
        );

        return null;
      } else {
        final heicFormat = file.path.split('.').last.toLowerCase();
        PrintUtils.customLog(
          'image size: ${(file.lengthSync()) / (1024 * 1024)}',
        );

        if ((file.lengthSync()) / (1024 * 1024) > 1.0 ||
            heicFormat == 'heic' ||
            heicFormat == 'hevc') {
          File compressedFile = await ImageUtils.compressImage(
            file.path,
            quality: 40,
          );
          return [compressedFile];
        } else {
          return [file];
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        var status = await Permission.camera.request();
        if (status.isGranted) {
          await getCameraImageFiles(isLoading: isLoading, context: context);
        } else if (status.isDenied) {
          showD(
            context: context,
            title: 'Camera Access Denied',
            message: guidelines,
          );

          // Permission denied
        } else if (status.isPermanentlyDenied) {
          showD(
            context: context,
            title: 'Camera Access Denied',
            message: guidelines,
          );
          // Permission permanently denied, take the user to app settings
        }
      }
    } catch (e) {
      PrintUtils.customLog('Error :- $e');
      return null;
    }
    return null;
  }
}
