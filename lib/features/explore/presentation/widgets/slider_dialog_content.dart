// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/screens/explore_screen.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../providers/explore_state_provider.dart';
import '../providers/filter_state_provider.dart';
import 'custom_thumb_shape.dart';

class SliderDialogContent extends ConsumerWidget {
  const SliderDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderData = ref.watch(sliderRangeProvider);

    double getZoomLevel(double radiusInMeters) {
      const earthCircumferenceMeters =
          40075000.0; // Earth's circumference at the equator in meters
      double scale = earthCircumferenceMeters / (radiusInMeters * 2);
      return log(scale) / log(3);
    }

    void setZoomForRadius(double radiusInMiles) {
      // Convert miles to meters (1 mile = 1609.34 meters)
      double radiusInMeters = radiusInMiles * 1609.34;

      // Calculate zoom level dynamically
      double zoomLevel = getZoomLevel(radiusInMeters);
      ref.read(zoomLevelState.notifier).state = zoomLevel * 1.75;
      // final cameraState = ref.read(mapControllerState.notifier).state;

      // if (locationState.currentLatLng != null) {
      //   // Move camera with the new zoom level
      //   cameraState?.animateCamera(
      //     CameraUpdate.newCameraPosition(
      //       CameraPosition(
      //         target: locationState.currentLatLng!,
      //         zoom: zoomLevel,
      //       ),
      //     ),
      //   );
      // }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Distance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if ((ref.read(filterNotifierProvider).radius ?? 0) > 0)
              TextIconButtonWidget(
                onPressed: () {
                  ref
                      .read(filterNotifierProvider.notifier)
                      .toRadiusInitalState();
                  Navigator.of(context).pop();
                  ref.invalidate(sliderRangeProvider);
                },
              ),
          ],
        ),
        Spacing.sizedBoxH_60(),
        SfSlider(
          min: 0.0,
          max: 50.0,
          activeColor: AppColors.primary,
          inactiveColor: AppColors.surfaceContainerLow,
          value: sliderData,
          interval: 5,
          thumbShape: CustomThumbShape(),
          showTicks: false,
          showLabels: false,
          enableTooltip: true,
          shouldAlwaysShowTooltip: true,
          // tickPlacement: TickPlacement.both,
          labelPlacement: LabelPlacement.onTicks,

          onChanged: (value) {
            ref.read(sliderRangeProvider.notifier).state = value;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0 mile', style: Theme.of(context).textTheme.bodyMedium),
              Text('50 miles', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        Spacing.sizedBoxH_16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ActionButton(
              height: 36,
              label: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: AppColors.primary,
              buttonColor: Colors.white,
            ),
            Spacing.sizedBoxW_16(),
            ActionButton(
              height: 36,
              label: 'Apply',
              onPressed: () {
                ref
                    .read(filterNotifierProvider.notifier)
                    .updateState(
                      radius: ref.read(sliderRangeProvider.notifier).state,
                    );
                setZoomForRadius(ref.read(sliderRangeProvider.notifier).state);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
