// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/permission_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:permission_handler/permission_handler.dart';

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
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Give more time for app to initialize
      // First check the current status
      final currentStatus = await Permission.appTrackingTransparency.status;

      if (currentStatus.isDenied) {
        await Future.delayed(
          const Duration(seconds: 1),
        ); // Give more time for app to initialize
        await Permission.appTrackingTransparency.request();
        await Future.delayed(
          const Duration(seconds: 2),
        ); // Give more time for app to initialize
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

    // Handle app tracking permission first
    Future.microtask(() async {
      await _handleAppTrackingPermission();
      await _handleLocationPermission();
    });

    Future.delayed(const Duration(milliseconds: 900), () async {
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
        child: Image.asset('assets/launcher.png', height: 150, width: 150),
      ),
    );
  }
}
