import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: AppColors.primary.withOpacity(0.5),
      progressIndicator: const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.primary,
          valueColor: AlwaysStoppedAnimation(AppColors.white),
        ),
      ),
      child: child,
    );
  }
}
