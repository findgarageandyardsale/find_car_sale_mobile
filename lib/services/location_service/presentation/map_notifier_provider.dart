// Create a provider for the LocationRepository
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/location_service/data/repositories/location_repositoru_impl.dart';

import 'state/location_state.dart';
import 'state/map_notifier.dart';

final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  return LocationRepositoryImpl();
});

// Create a StateNotifierProvider for the MapNotifier
final mapNotifierProvider = StateNotifierProvider<MapNotifier, LocationState>((
  ref,
) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return MapNotifier(locationRepository);
});
