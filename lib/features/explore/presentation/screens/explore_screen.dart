import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/explore_state_provider.dart';
import 'package:findcarsale/features/explore/presentation/providers/state/explore_state.dart';
import 'package:findcarsale/features/explore/presentation/providers/state/filter_state.dart';
import 'package:findcarsale/features/explore/presentation/widgets/categories_list_bottomsheet.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/core/custom_debouncer.dart';
import '../../../../shared/enum/filter_enum.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottomsheet.dart';
import '../../../../shared/widgets/custom_filter_chip.dart';
import '../../../../shared/widgets/main_shimmer.dart';
import '../../../authentication/presentation/widgets/auth_field.dart';
import '../providers/filter_state_provider.dart';
import '../widgets/slider_dialog_content.dart';
import 'list_explore.dart';
import 'map_explore.dart';

@RoutePage()
class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  bool listView = true;
  bool isSearchActive = false;
  bool isLoading = true;
  DateFilter? selectedDateFilter;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    scrollController.addListener(scrollControllerListener);

    listView = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(exploreNotifierProvider.notifier);

      notifier.fetchExplorePosts(search: searchController.text);
    }
  }

  Future<void> _refreshPosts() async {
    final notifier = ref.read(exploreNotifierProvider.notifier);
    searchController.text = '';
    notifier
      ..resetState()
      ..fetchExplorePosts(
        search: searchController.text,
      ); // Assuming you have a refresh method
  }

  void refreshScrollControllerListener() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.addListener(scrollControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exploreNotifierProvider);

    final filterState = ref.watch(filterNotifierProvider);
    final debouncer = CustomDebouncer(milliseconds: 900);

    ref.listen(exploreNotifierProvider.select((value) => value), ((
      ExploreState? previous,
      ExploreState next,
    ) {
      //show Snackbar on failure
      if (next.state == ExploreConcreteState.fetchedAllExplore) {
        if (next.message.isNotEmpty &&
            !(next.message.toString().toLowerCase().contains('success'))) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.message.toString())));
        }
      }
    }));

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
                // maxDate: DateTime(2025, 1, 1),
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

    bool? checkActive(FilterEnum tag) {
      switch (tag) {
        case FilterEnum.all:
          {
            return (filterState.zipCode == null &&
                filterState.radius == null &&
                filterState.endDate == null &&
                filterState.isGarage == null &&
                (filterState.selectedCategories ?? []).isEmpty);
          }

        case FilterEnum.date:
          {
            return filterState.endDate != null;
          }
        case FilterEnum.distance:
          return filterState.radius != null;

        case FilterEnum.categories:
          return (filterState.selectedCategories ?? []).isNotEmpty;
      }
    }

    void enumOnTap(FilterEnum tag) {
      switch (tag) {
        case FilterEnum.all:
          {
            selectedDateFilter = null;
            ref.read(filterNotifierProvider.notifier).updateToInitial();
            if (PrintUtils.radiusInAllChip != true) {
              ref.read(filterNotifierProvider.notifier).toRadiusInitalState();
            }
          }

        case FilterEnum.date:
          {
            primaryBottomSheet(
              padding: EdgeInsets.zero,
              context,
              child: Column(
                children: [
                  if (selectedDateFilter != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: TextIconButtonWidget(
                        onPressed: () {
                          ref
                              .read(filterNotifierProvider.notifier)
                              .toDateInitalState();
                          selectedDateFilter = null;

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: DateFilter.values.length,
                    itemBuilder: (context, index) {
                      final endList = index == DateFilter.values.length - 1;
                      if (endList) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          title: Text(
                            'Custom range',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: AppColors.primary),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            showDateRangePickerDialog();
                          },
                        );
                      }
                      //          if (DateFilter.values[index] == selectedDateFilter.value) {
                      //   Navigator.pop(context);
                      // }

                      DateTime? sDate, eDate;
                      return RadioListTile(
                        title: Text(DateFilter.values[index].name),
                        value: DateFilter.values[index],
                        groupValue: (endList) ? null : selectedDateFilter,
                        onChanged: (dateFilter) {
                          switch (dateFilter) {
                            case DateFilter.today:
                              sDate = DateTime.now();
                              eDate = DateTime.now();
                              break;
                            case DateFilter.toWeek:
                              sDate = DateTime.now().subtract(
                                const Duration(days: 7),
                              );
                              eDate = DateTime.now();
                              break;
                            case DateFilter.toMonth:
                              sDate = DateTime.now().subtract(
                                const Duration(days: 30),
                              );
                              eDate = DateTime.now();
                              break;
                            case DateFilter.customRange:
                              showDateRangePickerDialog();
                              break;
                            case null:
                              sDate = null;
                              eDate = null;
                              break;
                          }
                          Navigator.pop(context);
                          ref
                              .read(filterNotifierProvider.notifier)
                              .updateState(startDate: sDate, endDate: eDate);
                          selectedDateFilter = dateFilter!;
                        },
                      );
                    },
                  ),
                ],
              ),

              /* Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    value: false,
                    groupValue: 'group1',
                    onChanged: (val) {
                      ref.read(filterNotifierProvider.notifier).updateState(
                          startDate: DateTime.now(), endDate: null);
                    },
                    title: const Text('Today'),
                  ),
                  RadioListTile(
                    value: false,
                    groupValue: 'group1',
                    onChanged: (val) {
                      Navigator.of(context).pop();
                      ref.read(filterNotifierProvider.notifier).updateState(
                            startDate: DateTime.now(),
                            endDate: DateTime.now().subtract(
                              const Duration(days: 6),
                            ),
                          );
                    },
                    title: const Text('This week'),
                  ),
                  RadioListTile(
                    value: false,
                    groupValue: 'group1',
                    onChanged: (val) {
                      Navigator.of(context).pop();

                      ref.read(filterNotifierProvider.notifier).updateState(
                            startDate: DateTime.now(),
                            endDate: DateTime.now().subtract(
                              const Duration(days: 30),
                            ),
                          );
                    },
                    title: const Text('This month'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        showDateRangePickerDialog();
                      },
                      child: Text(
                        'Custom Range',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                  Spacing.sizedBoxH_16()

                  
                ],
              ),
              */
            );
          }
        case FilterEnum.distance:
          {
            showSliderDialog(context);
          }

        case FilterEnum.categories:
          {
            //

            primaryBottomSheet(
              padding: EdgeInsets.zero,
              context,
              child: const CategoriesListBottomsheet(),
            );
          }
      }
    }

    void searchAction() {
      ref.read(exploreNotifierProvider.notifier).resetFetchingStateToPage0();
      debouncer.run(() {
        ref
            .read(exploreNotifierProvider.notifier)
            .fetchExplorePosts(search: searchController.text);

        refreshScrollControllerListener();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Car Sale')),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Explore',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          setState(() {
            listView = !listView;
          });
        },
        child: Icon(listView ? Icons.map_outlined : Icons.list),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (listView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AuthField(
                  name: 'search',
                  hintText: 'Search',
                  controller: searchController,
                  fillColor: AppColors.surfaceContainerLow,
                  onChanged: (val) => searchAction(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      searchController.text.isEmpty
                          ? Icons.search
                          : Icons.close,
                      color: AppColors.black,
                    ),
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {
                        searchController.clear();
                      }
                      searchAction();
                    },
                  ),
                  borderRadius: 30.0,
                ),
              ),
            Spacing.sizedBoxH_16(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0, // Horizontal spacing between chips
                runSpacing: 8.0, // Vertical spacing between rows
                children:
                    FilterEnum.values.map((tag) {
                      return CustomFilterChip(
                        text: tag.filterValue,
                        onTap: () => enumOnTap(tag),
                        isActive: checkActive(tag) ?? false,
                      );
                    }).toList(),
              ),
            ),
            // SizedBox(
            //     height: 32,
            //     child: ListView.separated(
            //       separatorBuilder: (context, index) =>
            //           Spacing.sizedBoxW_08(),
            //       itemBuilder: (context, index) => Padding(
            //         padding: EdgeInsets.only(
            //             left: (index == 0) ? 16.0 : 0,
            //             right: (index == FilterEnum.values.length - 1)
            //                 ? 16.0
            //                 : 0),
            //         child: CustomFilterChip(
            //           text: FilterEnum.values[index].filterValue,
            //           onTap: () => enumOnTap(FilterEnum.values[index]),
            //           isActive:
            //               checkActive(FilterEnum.values[index]) ?? false,
            //         ),
            //       ),
            //       itemCount: FilterEnum.values.length,
            //       scrollDirection: Axis.horizontal,
            //     )),

            /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: FilterEnum.values.map((tag) {
                    return CustomFilterChip(
                      text: tag.filterValue,
                      onTap: () => enumOnTap(tag),
                      isActive: checkActive(tag) ?? false,
                    );
                  }).toList(),
                ),
              ),

              */
            Spacing.sizedBoxH_16(),
            state.state == ExploreConcreteState.loading
                ? const Expanded(child: MainViewShimmer())
                : state.hasData
                ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshPosts,
                    child:
                        listView
                            ? ListExplore(scrollController: scrollController)
                            : const MapExplore(),
                  ),
                )
                : Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void showSliderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SliderDialogContent(),
          ),
        );
      },
    );
  }
}

class TextIconButtonWidget extends StatelessWidget {
  const TextIconButtonWidget({super.key, required this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: const Text('Clear Filter'),
      icon: const Icon(Icons.clear),
    );
  }
}
