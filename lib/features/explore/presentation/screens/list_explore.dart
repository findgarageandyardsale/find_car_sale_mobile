import 'package:findcarsale/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/filter_state_provider.dart';
import 'package:findcarsale/shared/widgets/main_shimmer.dart';
import 'package:findcarsale/shared/widgets/no_data.dart';

import '../../../../shared/widgets/post_single_item.dart';
import '../providers/explore_state_provider.dart';
import '../providers/state/explore_state.dart';

class ListExplore extends ConsumerWidget {
  const ListExplore({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exploreNotifierProvider);
    final filterstate = ref.watch(filterNotifierProvider);

    // final list = DummyDataService.getDummyGarageYardList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /* Scrollbar(
          controller: scrollController,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (context, index) {
              return PostSingleItem(singlePost: list[index]);
            },
            itemCount: list.length,
          ),
        ),

        */
        Flexible(
          child:
              state.garageYardList.isEmpty
                  ? SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ), // Optional for spacing
                      child: Center(
                        child: NoData(
                          fromAdd: false,
                          matchingValueText:
                              filterstate.radius != null
                                  ? ' with ${filterstate.radius} miles'
                                  : null,
                        ),
                      ),
                    ),
                  )
                  : Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        return PostSingleItem(
                          singlePost: state.garageYardList[index],
                        );
                      },
                      itemCount: state.garageYardList.length,
                    ),
                  ),
        ),
        if (state.state == ExploreConcreteState.fetchingMore)
          const Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: MainViewShimmer(),
            ),
          ),
      ],
    );
  }
}
