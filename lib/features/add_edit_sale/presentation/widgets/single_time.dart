// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/utils/cusotm_date_utils.dart';
import '../../../authentication/presentation/widgets/auth_field.dart';
import '../provider/add_data_provider.dart';

class SingleTime extends ConsumerStatefulWidget {
  const SingleTime({super.key, required this.isGarage, required this.timeSlot});
  final AvailableTimeSlot timeSlot;
  final bool isGarage;

  @override
  ConsumerState<SingleTime> createState() => _SingleTimeState();
}

class _SingleTimeState extends ConsumerState<SingleTime> {
  final TextEditingController dateController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();

  final TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // getEarlyDate();
      dateController.text = CustomDateUtils.formatDate(
        widget.timeSlot.date ?? DateTime.now(),
      );
      startTimeController.text =
          (widget.timeSlot.startTime != null)
              ? widget.timeSlot.startTime!
              : CustomDateUtils.formatTimeOfDay(TimeOfDay.now(), context);
      endTimeController.text =
          (widget.timeSlot.endTime != null)
              ? widget.timeSlot.endTime!
              : CustomDateUtils.formatTimeOfDay(TimeOfDay.now(), context);
    });
  }

  DateTime? earliestDate;

  void getEarlyDate() {
    try {
      final availableSlot =
          (ref.read(addDataNotifierProvider)?.availableTimeSlots ?? []);
      // Filter out slots with null dates
      final slotsWithDates =
          availableSlot.where((slot) => slot.date != null).toList();

      if (slotsWithDates.isNotEmpty && slotsWithDates.length > 1) {
        // Find the slot with the earliest date
        final earliestSlot = slotsWithDates.reduce(
          (a, b) => a.date!.isBefore(b.date!) ? a : b,
        );
        if (earliestSlot.date != null) {
          if (earliestSlot.date != null) {
            earliestDate = earliestSlot.date!.add(const Duration(days: 30));
          }
          // earliestDate = DateTime(
          //   earliestSlot.date!.year,
          //   earliestSlot.date!.month + 1,
          //   earliestSlot.date!.day,
          // );
        }
      } else {
        earliestDate = DateTime(2050, 1, 1);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !(widget.timeSlot.isEditable ?? true),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      (widget.timeSlot.isEditable ?? true)
                          ? Colors.grey
                          : Colors.red,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  AuthField(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate:
                        //  earliestDate ??
                        DateTime(2050, 1, 1),
                        initialDate: widget.timeSlot.date ?? DateTime.now(),
                      );

                      if (date != null) {
                        dateController.text = CustomDateUtils.formatDate(date);
                        ref
                            .read(addDataNotifierProvider.notifier)
                            .editTimeSlot(widget.timeSlot.copyWith(date: date));
                      }
                    },
                    name: 'date${widget.key}',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                    labelText: 'Date',
                    hintText: 'Date',
                    controller: dateController,
                  ),
                  Spacing.sizedBoxH_16(),
                  Row(
                    children: [
                      Expanded(
                        child: AuthField(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: CustomDateUtils.stringToTimeOfDay(
                                startTimeController.text,
                              ),
                              initialEntryMode: TimePickerEntryMode.inputOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: AppTheme.lightTheme.copyWith(
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.labelLarge?.copyWith(
                                          color: AppColors.primary,
                                        ), // Text color of the buttons
                                      ),
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      hourMinuteTextColor:
                                          AppColors
                                              .black, // Change hour and minute text color
                                      hourMinuteShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      inputDecorationTheme:
                                          const InputDecorationTheme(),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (time != null) {
                              startTimeController
                                  .text = CustomDateUtils.formatTimeOfDay(
                                time,
                                context,
                              );
                              ref
                                  .read(addDataNotifierProvider.notifier)
                                  .editTimeSlot(
                                    widget.timeSlot.copyWith(
                                      startTime:
                                          CustomDateUtils.formatTimeOfDay(
                                            time,
                                            context,
                                          ),
                                    ),
                                  );
                            }
                          },
                          name: 'start_time${widget.key}',
                          hintText: 'Start Time',
                          labelText: 'Start Time',
                          readOnly: true,
                          suffixIcon: const Icon(Icons.access_time_rounded),
                          controller: startTimeController,
                        ),
                      ),
                      Spacing.sizedBoxW_16(),
                      Expanded(
                        child: AuthField(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: CustomDateUtils.stringToTimeOfDay(
                                endTimeController.text,
                              ),
                              initialEntryMode: TimePickerEntryMode.inputOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: AppTheme.lightTheme.copyWith(
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.labelLarge?.copyWith(
                                          color: AppColors.primary,
                                        ), // Text color of the buttons
                                      ),
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      hourMinuteTextColor:
                                          AppColors
                                              .black, // Change hour and minute text color
                                      hourMinuteShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      inputDecorationTheme:
                                          const InputDecorationTheme(),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (time != null) {
                              endTimeController
                                  .text = CustomDateUtils.formatTimeOfDay(
                                time,
                                context,
                              );
                              ref
                                  .read(addDataNotifierProvider.notifier)
                                  .editTimeSlot(
                                    widget.timeSlot.copyWith(
                                      endTime: CustomDateUtils.formatTimeOfDay(
                                        time,
                                        context,
                                      ),
                                    ),
                                  );
                            }
                          },
                          name: 'end_time${widget.key}',
                          readOnly: true,
                          hintText: 'End Time',
                          labelText: 'End Time',
                          suffixIcon: const Icon(Icons.access_time_rounded),
                          controller: endTimeController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.timeSlot.isEditable ?? true)
            Positioned(
              right: -8,
              top: -8,
              child: IconButton(
                icon: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.white,
                  child: Icon(
                    Icons.close,
                    color:
                        widget.isGarage
                            ? AppColors.secondary
                            : AppColors.tertiary,
                  ),
                ),
                onPressed: () {
                  ref
                      .read(addDataNotifierProvider.notifier)
                      .removeTimeSlot(widget.timeSlot);
                },
              ),
            ),
        ],
      ),
    );
  }
}
