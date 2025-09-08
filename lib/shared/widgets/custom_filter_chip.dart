import 'package:flutter/material.dart';

import '../constants/spacing.dart';
import '../theme/app_colors.dart';

class CustomFilterChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final Color? unactiveColor;
  final Color? activeColor;

  const CustomFilterChip({
    super.key,
    required this.text,
    this.isActive = false,
    this.unactiveColor,
    this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor ?? AppColors.secondaryContainer
                : (unactiveColor ?? AppColors.white),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isActive ? Colors.transparent : AppColors.black),
          ),
          child: Row(
            mainAxisSize: MainAxisSize
                .min, // Ensures the Row sizes itself based on its children

            children: [
              if (isActive)
                const Icon(
                  Icons.check,
                ),
              if (isActive) Spacing.sizedBoxW_08(),
              Text(
                text,
              ),
            ],
          )),
    );
  }
}
