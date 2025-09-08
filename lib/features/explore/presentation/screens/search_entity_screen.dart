import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/auth_field.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:findcarsale/shared/widgets/app_image.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../shared/theme/app_colors.dart';
import '../providers/filter_state_provider.dart';
import '../widgets/slider_dialog_content.dart';

@RoutePage()
class SearchEntityScreen extends ConsumerWidget {
  SearchEntityScreen({super.key});

  final TextEditingController zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterNotifierProvider);
    ref.watch(sliderRangeProvider);

    void showDateRangePickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Date Range'),
            content: SizedBox(
              height: 400, // Set the height of the dialog
              width: 300, // Set the width of the dialog
              child: SfDateRangePicker(
                showTodayButton: false,
                maxDate: DateTime(2025, 1, 1),
                initialSelectedRange: PickerDateRange(
                  filterState.startDate,
                  filterState.endDate ?? filterState.startDate,
                ),
                monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  backgroundColor: AppColors.white,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                showActionButtons: true,
                backgroundColor: AppColors.white,
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onSubmit: (dateRange) {
                  if (dateRange is PickerDateRange) {
                    ref
                        .read(filterNotifierProvider.notifier)
                        .updateState(
                          startDate: dateRange.startDate,
                          endDate: dateRange.endDate,
                        );
                  }
                  Navigator.of(context).pop();
                },
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs args) {},
                selectionMode: DateRangePickerSelectionMode.range,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search Garage/Yard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: AppImage()),
              Spacing.sizedBoxH_16(),
              AuthField(
                name: 'zip_code',
                hintText: 'Zip Code',
                controller: zipCodeController,
                onChanged: (value) {
                  ref
                      .read(filterNotifierProvider.notifier)
                      .updateState(zipCode: value);
                },
              ),
              Spacing.sizedBoxH_30(),
              Center(
                child: Text(
                  'OR',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacing.sizedBoxH_30(),
              Text(
                'Search by Radius',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Spacing.sizedBoxH_08(),
              const SliderDialogContent(),
              Spacing.sizedBoxH_16(),
              InkWell(
                onTap: () {
                  showDateRangePickerDialog();
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Custom Date Range',
                    enabled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(filterState.formattedStartDate),
                ),
              ),
              Spacing.sizedBoxH_16(),
              ActionButton(
                width: double.infinity,
                label: 'Apply Search',
                onPressed: () {
                  context.router.push(const ExploreScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
