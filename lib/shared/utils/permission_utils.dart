import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
// Function to request location permissions
  Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }

// Function to check if location permissions are granted
  Future<bool> isLocationPermissionGranted() async {
    PermissionStatus status = await Permission.location.status;
    return status.isGranted;
  }

// Function to check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }

// Function to check if location permissions are denied permanently
  Future<bool> isLocationPermissionDeniedPermanently() async {
    PermissionStatus status = await Permission.location.status;
    return status.isDenied &&
        !await Permission.location.shouldShowRequestRationale;
  }

// Function to open app settings
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  Future<void> cameraStoragepermissionRequest() async {
    await [Permission.camera, Permission.microphone, Permission.storage]
        .request();
  }

  Future<void> storagePermissionRequest() async {
    await [Permission.storage].request();
  }

  Future<void> camerMicrophonePermissionRequest() async {
    await [Permission.camera, Permission.microphone].request();
  }
}
