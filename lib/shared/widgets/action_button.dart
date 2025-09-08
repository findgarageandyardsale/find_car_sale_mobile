import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? textColor;
  final IconData? icon;

  final Color? buttonColor;
  final Color? borderColor;
  final Color? iconColor;

  final double? width;
  final double? height;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor,
    this.iconColor,
    this.icon,
    this.buttonColor,
    this.borderColor,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            buttonColor ?? Theme.of(context).primaryColor,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            textColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(color: borderColor ?? AppColors.primary),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: iconColor),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
