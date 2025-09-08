// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:findcarsale/shared/core/app_context.dart';
import 'package:findcarsale/shared/utils/image_utils.dart';
import 'package:findcarsale/shared/utils/permission_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

///File picker mixin class
mixin FilePickerMixin {
  /// pick files and returns [List<File>? files] - from which we can access files paths
  Future<List<File>?> getFiles({
    FileType type = FileType.any,
    bool? allowMultiple = true,
  }) async {
    await PermissionUtils().cameraStoragepermissionRequest();

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
        if (e != null) {
          if (await ImageUtils.isFileGreatherThan25mb(path: e)) {
            CustomToast.showToast(
              'The file may not be greater than 25 MB.',
              status: ToastStatus.error,
            );
          } else {
            final file = await ImageUtils.compressImage(e);

            files.add(file);
          }
        }
      }
      return files;
    } else {
      return null;
    }
  }

  // checks permission, file size, converts heic & hevc and gets the image file
  Future<List<File>?> getOnlyImageFiles({
    bool? allowMultiple = false,
    void Function()? isLoading,
  }) async {
    String guidelines = '''

To utilize this feature, please follow these steps to enable storage access on your device:

1. Access App Settings
2. Find App Permissions
3. Locate Storage Permission
4. Enable Storage Access
5. If specified separately, ensure access to Photos and Videos
6. Return to App
''';
    try {
      await PermissionUtils().storagePermissionRequest();

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple ?? false,
        onFileLoading: (status) {
          return const Center(child: CircularProgressIndicator());
        },
        type: FileType.image,
      );
      if (isLoading != null) isLoading();
      if (result != null) {
        List<File> files = [];
        for (var e in result.paths) {
          if (e != null) {
            if (await ImageUtils.isFileGreatherThan25mb(path: e)) {
              CustomToast.showToast(
                'The file may not be greater than 25 MB.',
                status: ToastStatus.error,
              );
            } else {
              final file = await ImageUtils.compressImage(e);

              files.add(file);
            }
          }
        }
        return files;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      if ((e.code == 'storage_access_denied') ||
          (e.code == 'read_external_storage_denied')) {
        var status = await Permission.camera.request();
        if (status.isGranted) {
          await getOnlyImageFiles(
            isLoading: isLoading,
            allowMultiple: allowMultiple,
          );
        } else if (status.isDenied) {
          showD(title: 'Storage Access Denied', message: guidelines);

          // Permission denied
        } else if (status.isPermanentlyDenied) {
          showD(title: 'Storage Access Denied', message: guidelines);
          // Permission permanently denied, take the user to app settings
        }
      }
    } catch (e) {
      PrintUtils.customLog(e.toString());
      return null;
    }
    return null;
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

  void showD({String? title, required String message}) {
    BuildContext? context = AppContext().getContext();
    if (context != null) {
      showMessageInDialog(
        context: context,
        title: title ?? '',
        message: message,
      );
    } else {
      CustomToast.showToast(message, status: ToastStatus.info);
      Future.delayed(const Duration(seconds: 5), () {
        openAppSettings(); // Close the dialog
      });
    }
  }

  // checks device permission, platform, file size and gets the Image
  Future<List<File>?> getCameraImageFiles({void Function()? isLoading}) async {
    String guidelines = '''

To utilize this feature, please follow these steps to enable camera access on your device:

1. Access App Settings
2. Find App Permissions
3. Locate Camera Permission
4. Enable Camera Access
5. Return to App
''';

    try {
      await PermissionUtils().camerMicrophonePermissionRequest();
      final result = await ImagePicker.platform.getImageFromSource(
        source: ImageSource.camera,
      );
      if (isLoading != null) isLoading();
      if (result == null) return null;
      final path = result.path;
      if (path.isNotEmpty) {
        if (await ImageUtils.isFileGreatherThan25mb(path: path)) {
          CustomToast.showToast(
            'The file may not be greater than 25 MB.',
            status: ToastStatus.error,
          );
        } else {
          final file = await ImageUtils.compressImage(
            path,
            isActuallyImage: true,
          );
          return [file];
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        var status = await Permission.camera.request();
        if (status.isGranted) {
          await getCameraImageFiles(isLoading: isLoading);
        } else if (status.isDenied) {
          showD(title: 'Camera Access Denied', message: guidelines);

          // Permission denied
        } else if (status.isPermanentlyDenied) {
          showD(title: 'Camera Access Denied', message: guidelines);
          // Permission permanently denied, take the user to app settings
        }
      }
    } catch (e) {
      PrintUtils.customLog(e.toString());
      return null;
    }
    return null;
  }
}
