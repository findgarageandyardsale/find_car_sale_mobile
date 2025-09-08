// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

import '../provider/sale_state_provider.dart';

@RoutePage()
class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});
  // bool _isInitialIndexSet = false;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     ref.read(isExpiredSalesProvider.notifier).state = false;
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(saleNotifierProvider);
    ref.watch(isExpiredSalesProvider);

    return AutoTabsRouter.tabBar(
      routes: const [ActiveSalesScreen(), ExpiredScreen()],
      builder: (context, child, controller) {
        // // Ensure the first tab is selected by default only once
        // // Add a listener to the TabController
        controller.addListener(() {
          // Check if the tab is actually changing (not from an animation or other effects)
          if (!controller.indexIsChanging) {
            final currentIndex = controller.index;
            // // Set the loading state to true
            // ref.read(isLoadinShimmerProvider.notifier).state = true;

            // Do something based on the selected tab
            // For example, you can reload data or update the state
            if (currentIndex == 0) {
              ref.read(isExpiredSalesProvider.notifier).state = false;
              // Tab 0: Active Sales
            } else {
              // Tab 1: Expired
              ref.read(isExpiredSalesProvider.notifier).state = true;
            }

            // // Simulate a delay for loading
            // Future.delayed(const Duration(milliseconds: 500), () {
            //   ref.read(isLoadinShimmerProvider.notifier).state = false;
            // });
          }
        });
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: 'Sales',
            onPressed: () {
              context.router.push(AddEditPostSaleScreen()).then((value) {
                if (value != null && value == true) {
                  ref.read(saleNotifierProvider.notifier)
                    ..resetState()
                    ..fetchExplorePosts();
                }
              });
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: AppColors.white),
          ),
          appBar: AppBar(
            title: const Text('My Sales'),
            bottom: TabBar(
              dividerHeight: 1,
              onTap: (index) {
                // Do something based on the selected tab
                // For example, you can reload data or update the state
                if (index == 0) {
                  ref.read(isExpiredSalesProvider.notifier).state = false;
                  // Tab 0: Active Sales
                } else {
                  // Tab 1: Expired
                  ref.read(isExpiredSalesProvider.notifier).state = true;
                }
              },
              indicatorWeight: 4,
              dividerColor: AppColors.surfaceContainer,
              controller: controller,
              tabs: const [Tab(text: 'Active Sales'), Tab(text: 'Expired')],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: child,
          ),
        );
      },
    );
  }
}
