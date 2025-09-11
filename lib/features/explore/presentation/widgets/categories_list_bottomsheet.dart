import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/provider/car_condition_provider.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/widgets/title_head.dart';
import 'package:findcarsale/features/explore/presentation/providers/filter_state_provider.dart';
import 'package:findcarsale/features/explore/presentation/screens/explore_screen.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:findcarsale/shared/widgets/custom_filter_chip.dart';

class CategoriesListBottomsheet extends ConsumerStatefulWidget {
  const CategoriesListBottomsheet({super.key});

  @override
  ConsumerState<CategoriesListBottomsheet> createState() =>
      _CategoriesListBottomsheetState();
}

class _CategoriesListBottomsheetState
    extends ConsumerState<CategoriesListBottomsheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.watch(catListProvider.notifier).state =
          ref.read(filterNotifierProvider).selectedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(carconditionNotifierProvider);
    final catList = ref.watch(catListProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHead(
            title: 'Category',
            subtitle:
                (catList ?? []).isEmpty
                    ? null
                    : '${(catList ?? []).length} Selected',
            clearWidget:
                (catList ?? []).isEmpty
                    ? null
                    : TextIconButtonWidget(
                      onPressed: () {
                        ref.read(catListProvider.notifier).state = [];
                        ref
                            .read(filterNotifierProvider.notifier)
                            .updateState(
                              selectedCategories:
                                  ref.read(catListProvider.notifier).state,
                            );

                        Navigator.of(context).pop();
                      },
                    ),
          ),
          state.when(
            initial: () {
              return const SizedBox.shrink();
            },
            success: (categories) {
              List<CarCondition> cats =
                  (categories as List<dynamic>)
                      .map((category) => CarCondition.fromJson(category))
                      .toList();
              return cats.isEmpty
                  ? const SizedBox.shrink()
                  : CategorySelectorValue(cats: cats);
            },
            loading: () {
              return Wrap(
                runSpacing: 16.0,
                spacing: 12.0,
                children:
                    [1, 2, 3, 4, 5, 6]
                        .map(
                          (e) => Container(
                                width: 120.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                color: Colors.grey.shade300,
                                duration: const Duration(seconds: 2),
                              ),
                        )
                        .toList(),
              );
            },
            failure: (error) => Text(error.toString()),
          ),
          Spacing.sizedBoxH_20(),
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
                        selectedCategories:
                            ref.read(catListProvider.notifier).state,
                      );

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Spacing.sizedBoxH_20(),
        ],
      ),
    );
  }
}

class CategorySelectorValue extends StatelessWidget {
  const CategorySelectorValue({super.key, required this.cats});
  final List<CarCondition> cats;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16.0, // Vertical spacing between rows
      spacing: 12.0, // Horizontal spacing between chips
      children:
          cats.map((singleCat) {
            return Consumer(
              builder: (context, ref, __) {
                final state = ref.watch(catListProvider);

                bool isSelectedCategory(CarCondition category) {
                  final state = ref.watch(catListProvider);
                  return (state ?? []).any(
                    (element) => element.id == category.id,
                  );
                }

                void updateCat(CarCondition cat) {
                  try {
                    // Create a new list of categories to ensure state change
                    List<CarCondition> categories = List.from(state ?? []);

                    if (categories.contains(cat)) {
                      // Remove the category if it's already selected
                      categories.removeWhere((element) => element.id == cat.id);
                    } else {
                      // Add the category if it's not selected
                      categories.add(cat);
                    }

                    // Update the state with a new instance of Garageayard
                    ref.read(catListProvider.notifier).state = categories;
                  } catch (e) {
                    // log('UpdateCat Error: ${e.toString()}');
                  }
                }

                final isSelected = isSelectedCategory(singleCat);
                return CustomFilterChip(
                  text: singleCat.name ?? '',
                  activeColor:
                      // isGarage
                      //     ? AppColors.secondaryContainer
                      //     :
                      AppColors.secondaryBorder,
                  isActive: isSelected,
                  unactiveColor: Colors.transparent,
                  onTap: () {
                    //catListProvider
                    updateCat(singleCat);
                  },
                );
              },
            );
          }).toList(),
    );
  }
}
