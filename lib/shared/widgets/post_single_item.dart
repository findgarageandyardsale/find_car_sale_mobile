import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/utils/cusotm_date_utils.dart';
import 'package:findcarsale/shared/widgets/location_text.dart';

import '../constants/spacing.dart';
import '../theme/app_colors.dart';
import '../utils/app_utils.dart';
import 'file_image_builder.dart';
import 'status_chip.dart';
import 'timer_text.dart';

class PostSingleItem extends StatelessWidget {
  const PostSingleItem({
    super.key,
    this.isActive,
    required this.singlePost,
    this.onTap,
    this.fromMap,
  });
  final bool? isActive;
  final Garageayard? singlePost;
  final Function()? onTap;
  final bool? fromMap;

  @override
  Widget build(BuildContext context) {
    final isGarage = singlePost?.type == GarageYardType.garage;

    Widget locationWidget() {
      return LocationText(
        isGarage: isGarage,
        fromDetail: false,
        location: AppUtils.formatLocationAsAddress(
          singlePost?.location ?? const LocationModel(),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        context.router.push(
          PostDetailScreen(
            garageayard: singlePost ?? const Garageayard(),
            isActive: isActive,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isGarage ? AppColors.surfaceLight : AppColors.softColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color:
                isGarage ? AppColors.primaryBorder : AppColors.secondaryBorder,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((singlePost?.attachments ?? []).isNotEmpty)
              FileImageBuilder(
                height: 85,
                width: 85,
                fit: BoxFit.cover,
                url: singlePost?.attachments?.first.file ?? '',
                clickUrl: singlePost?.attachments?.first.file ?? '',
              ),
            Spacing.sizedBoxW_16(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    singlePost?.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacing.sizedBoxH_08(),
                  if (singlePost?.status != null)
                    StatusChip(status: (singlePost?.status)!),
                  Spacing.sizedBoxH_08(),
                  if ((singlePost?.availableTimeSlots ?? []).isNotEmpty)
                    TimerText(
                      isGarage: isGarage,
                      fromDetail: false,
                      date: CustomDateUtils.formatDate(
                        singlePost?.availableTimeSlots?[0].date ??
                            DateTime.now(),
                      ),
                      time:
                          '${CustomDateUtils.convertTo12HourFormat(singlePost?.availableTimeSlots?[0].startTime)} - ${CustomDateUtils.convertTo12HourFormat(singlePost?.availableTimeSlots?[0].endTime)}',
                      days:
                          ((singlePost?.availableTimeSlots ?? []).length - 1)
                              .toString(),
                    ),
                  Spacing.sizedBoxH_08(),
                  (fromMap == true)
                      ? Flexible(child: locationWidget())
                      : locationWidget(),
                ],
              ),
            ),
            if (onTap != null)
              InkWell(
                onTap: onTap,
                child: const Icon(Icons.clear, color: Colors.red, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
