// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/permission_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import '../../../../routes/app_route.dart';
import '../../../../routes/app_route.gr.dart';
import '../../../../shared/widgets/custom_toast.dart';
import '../providers/splash_provider.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final AppRouter appRouter = AppRouter();

  Future<void> _handleAppTrackingPermission() async {
    try {
      PrintUtils.customLog('Starting app tracking permission handling...');

      // Only handle app tracking on iOS
      if (!Platform.isIOS) {
        PrintUtils.customLog(
          'Not iOS platform, skipping app tracking permission',
        );
        return;
      }

      // Check iOS version - App Tracking Transparency requires iOS 14.5+
      final deviceInfo = DeviceInfoPlugin();
      final iosInfo = await deviceInfo.iosInfo;
      final systemVersion = iosInfo.systemVersion;
      PrintUtils.customLog('iOS version: $systemVersion');

      // Parse version to check if it's 14.5 or higher
      final versionParts = systemVersion.split('.');
      final majorVersion = int.tryParse(versionParts[0]) ?? 0;
      final minorVersion = int.tryParse(versionParts[1]) ?? 0;

      if (majorVersion < 14 || (majorVersion == 14 && minorVersion < 5)) {
        PrintUtils.customLog(
          'iOS version $systemVersion does not support App Tracking Transparency (requires 14.5+)',
        );
        return;
      }

      await Future.delayed(
        const Duration(seconds: 1),
      ); // Give more time for app to initialize

      // First check the current status
      final currentStatus = await Permission.appTrackingTransparency.status;
      PrintUtils.customLog('Current app tracking status: $currentStatus');

      if (currentStatus.isDenied) {
        PrintUtils.customLog(
          'App tracking permission is denied, requesting...',
        );
        await Future.delayed(
          const Duration(seconds: 1),
        ); // Give more time for app to initialize
        final requestResult =
            await Permission.appTrackingTransparency.request();
        PrintUtils.customLog(
          'App tracking permission request result: $requestResult',
        );
        await Future.delayed(
          const Duration(seconds: 2),
        ); // Give more time for app to initialize
      } else if (currentStatus.isGranted) {
        PrintUtils.customLog('App tracking permission already granted');
      } else if (currentStatus.isPermanentlyDenied) {
        PrintUtils.customLog('App tracking permission permanently denied');
      } else {
        PrintUtils.customLog('App tracking permission status: $currentStatus');
      }
    } catch (e) {
      PrintUtils.customLog('Error in app tracking permission: $e');
    }
  }

  Future<void> _handleLocationPermission() async {
    try {
      bool isGranted = await PermissionUtils().isLocationPermissionGranted();
      if (!isGranted) {
        bool permissionRequested =
            await PermissionUtils().requestLocationPermission();
        if (!permissionRequested) {
          if (await PermissionUtils().isLocationPermissionDeniedPermanently()) {
            CustomToast.showToast(
              "Location permission is required. Please enable it in settings.",
              status: ToastStatus.error,
            );
          }
        }
      }
    } catch (e) {
      PrintUtils.customLog('Error in location permission: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    PrintUtils.customLog('SplashScreen initState called');

    // Handle app tracking permission first
    Future.microtask(() async {
      PrintUtils.customLog('Starting permission handling in microtask...');
      await _handleAppTrackingPermission();
      await _handleLocationPermission();
      PrintUtils.customLog('Permission handling completed');
    });

    // Also try calling it after a longer delay to ensure app is fully loaded
    Future.delayed(const Duration(seconds: 3), () async {
      PrintUtils.customLog('Secondary permission check after 3 seconds...');
      await _handleAppTrackingPermission();
    });

    Future.delayed(const Duration(milliseconds: 900), () async {
      PrintUtils.customLog('Starting navigation after delay...');
      final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);
      final route =
          isUserLoggedIn
              ? DashboardScreen()
              : const CustomIntroScreen() as PageRouteInfo;
      AutoRouter.of(context).pushAndPopUntil(route, predicate: (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Image.asset('assets/launcher.jpeg', height: 150, width: 150),
      ),
    );
  }
}
