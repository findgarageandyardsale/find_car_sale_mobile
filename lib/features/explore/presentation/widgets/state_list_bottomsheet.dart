import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/filter_state_provider.dart';
import 'package:findcarsale/shared/globals.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class StateListBottomsheet extends ConsumerWidget {
  const StateListBottomsheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select State',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),

              TextButton(
                onPressed: () {
                  ref
                      .read(filterNotifierProvider.notifier)
                      .clearSelectedState();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Clear State',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: usStates.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final state = usStates[index];
              final isSelected = filterState.selectedState == state['name'];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${state['name']!} (${state['abbreviation']!})',
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? AppColors.primary : null,
                  ),
                ),
                trailing:
                    isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                onTap: () {
                  ref
                      .read(filterNotifierProvider.notifier)
                      .updateSelectedState(isSelected ? null : state['name']);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
