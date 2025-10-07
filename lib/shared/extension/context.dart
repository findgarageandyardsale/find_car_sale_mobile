import 'package:flutter/material.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import '../theme/app_colors.dart';

extension GarageScaffold on BuildContext {
  doublePos({
    required bool isGarage,
    required Widget content,
    List<Widget>? actions,
    VoidCallback? onPosPressed,
    VoidCallback? onNegPressed,
    bool? isActive,
    String? statusText,
    AppBar? appbar,
    Widget? actionButton,
  }) {
    Color color = isGarage ? AppColors.secondary : AppColors.green;
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: appbar,
        backgroundColor:
            isGarage ? AppColors.surfaceLight : AppColors.softColor,
        body: content,
        bottomNavigationBar:
            actionButton ??
            ((actions ?? []).length == 1
                ? null
                : isActive == null
                ? Container(
                  margin: const EdgeInsets.all(16),
                  child: ActionButton(
                    label: statusText ?? 'Get Directions ',
                    onPressed: onPosPressed,
                    borderColor: color,
                    buttonColor: color,
                    textColor: AppColors.white,
                  ),
                )
                : isActive
                ? Container(
                  margin: const EdgeInsets.all(16),
                  child: ActionButton(
                    label: 'Edit Sale ',
                    onPressed: onPosPressed,
                    borderColor: color,
                    buttonColor: color,
                    textColor: AppColors.white,
                  ),
                )
                : Container(
                  margin: const EdgeInsets.all(16),
                  child: ActionButton(
                    label: 'Extend Expiry',
                    onPressed: onPosPressed,
                    borderColor: color,
                    buttonColor: color,
                    textColor: AppColors.white,
                  ),
                )),
      ),
    );
  }
}
