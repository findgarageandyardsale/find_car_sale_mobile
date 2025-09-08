import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/main_shimmer.dart';
import '../../../../shared/widgets/no_data.dart';
import '../../../../shared/widgets/post_single_item.dart';
import '../../../explore/presentation/providers/state/explore_state.dart';
import '../provider/sale_state_provider.dart';

@RoutePage()
class ExpiredScreen extends ConsumerStatefulWidget {
  const ExpiredScreen({super.key});

  @override
  ConsumerState<ExpiredScreen> createState() => _ExpiredScreenState();
}

class _ExpiredScreenState extends ConsumerState<ExpiredScreen> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(saleNotifierProvider.notifier);

      notifier.fetchExplorePosts();
    }
  }

  void refreshScrollControllerListener() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.addListener(scrollControllerListener);
  }

  Future<void> _refreshPosts() async {
    final notifier = ref.read(saleNotifierProvider.notifier);
    notifier
      ..resetState()
      ..fetchExplorePosts(); // Assuming you have a refresh method
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(saleNotifierProvider);

    // ref.listen(
    //   saleNotifierProvider.select((value) => value),
    //   ((ExploreState? previous, ExploreState next) {
    //     //show Snackbar on failure
    //     if (next.state == ExploreConcreteState.fetchedAllExplore) {
    //       if (next.message.isNotEmpty) {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(SnackBar(content: Text(next.message.toString())));
    //       }
    //     }
    //   }),
    // );

    return state.state == ExploreConcreteState.loading
        ? const MainViewShimmer()
        : state.garageYardList.isEmpty
            ? RefreshIndicator(
                onRefresh: _refreshPosts,
                child: const SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 150.0),
                    child: Center(
                      child: NoData(
                        fromAdd: true,
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshPosts,
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemBuilder: (context, index) {
                              return PostSingleItem(
                                singlePost: state.garageYardList[index],
                                isActive: false,
                              );
                            },
                            itemCount: state.garageYardList.length),
                      ),
                    ),
                  ),
                  if (state.state == ExploreConcreteState.fetchingMore)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
  }
}
