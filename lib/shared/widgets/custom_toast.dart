import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

/// Enum for toast status
enum ToastStatus { success, error, info, defaulti }

/// Toast component class to display toast messages
class CustomToast {
  static showToast(
    String message, {
    ToastStatus status = ToastStatus.success,
    VoidCallback? onDismiss,
    double fontSize = 14,
    double borderRadius = 30,
    bool showIcon = true,
  }) {
    final iconData = _getIconData(status);
    final backgroundColor = _getBackgroundColor(status);

    showToastWidget(
      ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          color: backgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon) ...[
                Icon(iconData, color: Colors.white, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.barlowSemiCondensed(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 5),
      position: ToastPosition.bottom,
      onDismiss: onDismiss,
    );
  }

  static IconData _getIconData(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
        return Icons.check_circle_rounded;
      case ToastStatus.error:
        return Icons.warning;
      case ToastStatus.info:
      case ToastStatus.defaulti:
      default:
        return Icons.error;
    }
  }

  static Color _getBackgroundColor(ToastStatus status) {
    switch (status) {
      case ToastStatus.success:
        return AppColors.tertiary;
      case ToastStatus.error:
        return AppColors.secondary;
      case ToastStatus.info:
        return AppColors.primaryBorder;
      case ToastStatus.defaulti:
      default:
        return AppColors.primaryBorder;
    }
  }
}
