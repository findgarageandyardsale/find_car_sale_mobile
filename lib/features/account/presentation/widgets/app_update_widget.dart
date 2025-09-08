import 'dart:io';

import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:url_launcher/url_launcher.dart';

///[ App] update dialog body widget
class AppUpdateDialogBody extends StatelessWidget {
  const AppUpdateDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    void openStore() {
      if (Platform.isAndroid || Platform.isIOS) {
        final appId = Platform.isAndroid ? 'com.sale.garageyard' : '6737464722';
        final url = Uri.parse(
          Platform.isAndroid
              ? 'https://play.google.com/store/apps/details?id=$appId'
              : 'https://apps.apple.com/app/id$appId',
        );
        launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (val, result) {
        if (val) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Column(
            children: [
              const Icon(Icons.update, size: 48, color: AppColors.primary),
              Spacing.sizedBoxH_04(),
              Text(
                'Update Required',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          content: Text(
            'There’s a new update for Garage Yard app. Please update your app to continue.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: [
            ActionButton(
              width: double.infinity,
              label: 'UPDATE',
              onPressed: () => openStore(),
            ),
          ],
        ),
      ),
    );
  }
}
