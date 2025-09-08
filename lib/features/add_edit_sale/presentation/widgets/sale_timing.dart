import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';

import '../provider/add_data_provider.dart';
import 'single_time.dart';
import 'title_head.dart';

class SaleTiming extends ConsumerWidget {
  final bool isGarage;
  final int? totalSlot;
  const SaleTiming({super.key, required this.isGarage, this.totalSlot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableSlot =
        ref.watch(addDataNotifierProvider)?.availableTimeSlots ?? [];

    final garageayard = ref.watch(addDataNotifierProvider);
    final showMoney =
        garageayard?.status == StatusEnum.expired || garageayard?.id == null;

    bool? isDateWithinAvailableSlots(DateTime? dateToCheck) {
      try {
        if (dateToCheck == null) return null;
        final availableSlot =
            (ref.read(addDataNotifierProvider)?.availableTimeSlots ?? []);
        // Filter out slots with null dates
        final slotsWithDates =
            availableSlot.where((slot) => slot.date != null).toList();

        final earliestSlot = slotsWithDates.reduce(
          (a, b) => a.date!.isBefore(b.date!) ? a : b,
        );
        if (earliestSlot.date != null) {
          if (earliestSlot.date != null) {
            final startDate = earliestSlot.date!;
            final endDate = startDate.add(const Duration(days: 30));
            if (dateToCheck.isAfter(startDate) &&
                dateToCheck.isBefore(endDate)) {
              return true;
            }
          }
        }

        return false;
      } catch (_) {
        return false;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHead(
          title: 'Sale Timing',
          subtitle:
              showMoney
                  ? 'You can select any sale date for just \$${HelperConstant.priceForEach} each.'
                  : null,
        ),
        Spacing.sizedBoxH_16(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: availableSlot.length,
          itemBuilder: (context, index) {
            return SingleTime(
              key: ObjectKey(availableSlot[index].id ?? index),
              isGarage: isGarage,
              timeSlot: availableSlot[index],
            );
          },
        ),
        if (!(availableSlot.length >= 10))
          if (showMoney ||
              (garageayard?.id != null &&
                  (garageayard?.availableTimeSlots ?? []).length < totalSlot!))
            ActionButton(
              label: 'Add Another Sale Date',
              onPressed: () {
                try {
                  final slot =
                      (ref.read(addDataNotifierProvider)?.availableTimeSlots ??
                          []);
                  final lastAvailableSlot =
                      slot.isEmpty ? null : slot.last.date;
                  //check if lastAvailableSlot is between 1st and last day of the month

                  final changeDate =
                      lastAvailableSlot == null
                          ? null
                          : (lastAvailableSlot).add(const Duration(days: 1));
                  final isDateInMatch = isDateWithinAvailableSlots(changeDate);

                  ref
                      .read(addDataNotifierProvider.notifier)
                      .addInitialTimeSlot(
                        date:
                            isDateInMatch == null
                                ? null
                                : isDateInMatch == true
                                ? changeDate
                                : lastAvailableSlot,
                      );
                } catch (e) {
                  PrintUtils.customLog(e.toString());
                }
              },
              icon: Icons.add,
              buttonColor:
                  isGarage ? AppColors.surfaceLight : AppColors.softColor,
              textColor: isGarage ? AppColors.primary : AppColors.tertiary,
            ),
      ],
    );
  }
}
