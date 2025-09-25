import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/filter_state_provider.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

import '../../../../services/location_service/presentation/map_notifier_provider.dart';
import '../../domain/providers/explore_providers.dart';
import 'state/explore_notifier.dart';
import 'state/explore_state.dart';

// final mapControllerState = StateProvider<GoogleMapController?>((ref) {
//   return null;
// });
final zoomLevelState = StateProvider<double>((ref) {
  return 15.0;
});

final exploreNotifierProvider =
    StateNotifierProvider<ExploreNotifier, ExploreState>((ref) {
      final repository = ref.read(exploreRepositoryProvider);
      final filterState = ref.watch(filterNotifierProvider);
      final userLocationState = ref.read(mapNotifierProvider);

      return ExploreNotifier(repository, filterState, userLocationState)
        ..resetState()
        ..fetchExplorePosts();
    });

// Separate provider for map explore screen
final mapExploreNotifierProvider =
    StateNotifierProvider<ExploreNotifier, ExploreState>((ref) {
      final repository = ref.read(exploreRepositoryProvider);
      final filterState = ref.read(filterNotifierProvider);
      final userLocationState = ref.read(mapNotifierProvider);

      return ExploreNotifier(repository, filterState, userLocationState);
    });

// Provider to initialize explore data when location is available
final exploreInitializerProvider = Provider<void>((ref) {
  final exploreNotifier = ref.read(exploreNotifierProvider.notifier);
  final locationState = ref.watch(mapNotifierProvider);
  final exploreState = ref.read(exploreNotifierProvider);

  // Only fetch if location is available and we don't have data yet
  if (locationState.currentLatLng != null &&
      exploreState.garageYardList.isEmpty &&
      exploreState.state == ExploreConcreteState.initial) {
    exploreNotifier.resetState();
    exploreNotifier.fetchExplorePosts();
  }
});

// Provider to initialize map explore data when location is available
final mapExploreInitializerProvider = Provider<void>((ref) {
  final mapExploreNotifier = ref.read(mapExploreNotifierProvider.notifier);
  final locationState = ref.watch(mapNotifierProvider);
  final mapExploreState = ref.read(mapExploreNotifierProvider);

  // Only fetch if location is available and we don't have data yet
  if (locationState.currentLatLng != null &&
      mapExploreState.garageYardList.isEmpty &&
      mapExploreState.state == ExploreConcreteState.initial) {
    mapExploreNotifier.resetState();
    mapExploreNotifier.fetchExplorePosts();
  }
});

final detailPageProvider =
    StateNotifierProvider.autoDispose<DetailPageNotifier, FormzState>((ref) {
      final repository = ref.read(exploreRepositoryProvider);
      return DetailPageNotifier(repository);
    });
