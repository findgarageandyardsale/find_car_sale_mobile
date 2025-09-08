import 'package:flutter/material.dart';

import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

Future<bool> logOutDialogWidget({
  required BuildContext context,
  double? borderRadius = 5,
  required Function() logoutFunction,
}) async {
  AlertDialog alertDialog = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius!),
    ),
    insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.logout,
          size: 60,
          color: Theme.of(context).colorScheme.primary,
        ),
        Spacing.sizedBoxH_16(),
        Text(
          'Logout',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.surface,
            height: 1.43,
          ),
          textAlign: TextAlign.center,
        ),
        Spacing.sizedBoxH_08(),
        Text(
          'Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.surface,
            height: 1.5,
            letterSpacing: 0.4,
          ),
          textAlign: TextAlign.center,
        ),
        Spacing.sizedBoxH_20(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            Spacing.sizedBoxW_16(),
            TextButton(
              child: Text(
                'Logout',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
              ),
              onPressed: () {
                Navigator.pop(context);

                logoutFunction();
              },
            ),
          ],
        ),
      ],
    ),
  );
  return await showDialog(context: context, builder: (_) => alertDialog) ??
      false;
}
