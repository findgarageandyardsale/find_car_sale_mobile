// lib/notifiers/map_notifier.dart
import 'package:findcarsale/services/location_service/data/repositories/location_repositoru_impl.dart';
import 'package:findcarsale/shared/utils/permission_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:state_notifier/state_notifier.dart';
import 'location_state.dart';

class MapNotifier extends StateNotifier<LocationState> {
  final LocationRepositoryImpl locationRepository;
  bool _isInitialized = false;

  MapNotifier(this.locationRepository) : super(LocationState.initial()) {
    _initialize();
  }

  bool get isInitialized => _isInitialized;

  Future<void> _initialize() async {
    try {
      bool isGranted = await PermissionUtils().isLocationPermissionGranted();
      if (isGranted) {
        await getUserLocation();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Location permission is required.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to check location permission: $e',
      );
    }
  }

  // Method to get the user location
  Future<void> getUserLocation() async {
    if (_isInitialized) return;

    try {
      state = state.copyWith(isLoading: true, error: null);

      // Check if location services are enabled
      bool serviceEnabled = await locationRepository.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location services are disabled. Please enable GPS.',
        );
        return;
      }

      final position = await locationRepository.getCurrentPosition();
      state = state.copyWith(
        isLoading: false,
        currentLatLng: LatLng(position.latitude, position.longitude),
        error: null,
      );
      _isInitialized = true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to get location: $e',
      );
      _isInitialized =
          true; // Mark as initialized even on error to prevent retry loops
    }
  }

  // Method to retry getting location (useful when user enables GPS)
  Future<void> retryGetLocation() async {
    _isInitialized = false; // Reset initialization flag
    await getUserLocation();
  }
}
