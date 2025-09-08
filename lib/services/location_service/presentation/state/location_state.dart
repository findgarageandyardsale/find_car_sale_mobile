import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationState {
  final LatLng? currentLatLng;
  final CameraPosition? cameraPosition;
  final Position? currentPosition;
  final String currentLocationAddress;
  final Placemark? placemark;
  final bool isLoading;
  final String? error;

  LocationState({
    this.currentLatLng,
    this.cameraPosition,
    this.currentPosition,
    this.currentLocationAddress = '',
    this.placemark,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    LatLng? currentLatLng,
    CameraPosition? cameraPosition,
    Position? currentPosition,
    String? currentLocationAddress,
    Placemark? placemark,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      currentLatLng: currentLatLng ?? this.currentLatLng,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      currentPosition: currentPosition ?? this.currentPosition,
      currentLocationAddress:
          currentLocationAddress ?? this.currentLocationAddress,
      placemark: placemark ?? this.placemark,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // Factory constructor for the initial state
  factory LocationState.initial() {
    return LocationState(
      isLoading: true, // Starts loading by default
      currentLatLng: null,
      error: null,
    );
  }

  factory LocationState.loading() => LocationState(isLoading: true);

  factory LocationState.error(String error) => LocationState(error: error);
}
