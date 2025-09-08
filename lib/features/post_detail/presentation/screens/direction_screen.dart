import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../services/location_service/presentation/map_notifier_provider.dart';
import '../../../../services/location_service/presentation/state/location_state.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/widgets/custom_toast.dart';
import '../providers/polyline_state_provider.dart';

@RoutePage()
class DirectionScreen extends ConsumerWidget {
  const DirectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(mapNotifierProvider);
    final polylinePoints = ref.watch(polyLineNotifierProvider);

    // Trigger polyline fetch when location changes
    ref.listen<LocationState>(mapNotifierProvider, (previous, next) {
      if (next.currentLatLng != null) {
        final origin = next.currentLatLng!;
        const destination = LatLng(
          27.7045131,
          85.3071474,
        ); // Example destination offset
        ref
            .read(polyLineNotifierProvider.notifier)
            .getPolyLines(origin, destination);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            locationState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : locationState.error != null
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${locationState.error}'),
                      Spacing.sizedBoxH_16(),
                      ElevatedButton(
                        onPressed: () async {
                          bool opened = await openAppSettings();
                          if (!opened) {
                            CustomToast.showToast(
                              "Failed to open settings",
                              status: ToastStatus.error,
                            );
                          }
                        },
                        child: const Text('Open App Settings'),
                      ),
                    ],
                  ),
                )
                : locationState.currentLatLng != null
                ? GoogleMap(
                  mapType: MapType.terrain,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: locationState.currentLatLng!,
                    zoom: 14,
                  ),
                  polylines:
                      polylinePoints != null
                          ? {
                            Polyline(
                              polylineId: const PolylineId('polyline_id'),
                              color: AppColors.primary,
                              points:
                                  polylinePoints
                                      .map(
                                        (point) => LatLng(
                                          point.latitude,
                                          point.longitude,
                                        ),
                                      )
                                      .toList(),
                              width: 5,
                            ),
                          }
                          : {},
                  markers: {
                    Marker(
                      markerId: const MarkerId('current'),
                      position: locationState.currentLatLng!,
                    ),
                    const Marker(
                      markerId: MarkerId('destination'),
                      position: LatLng(27.7045131, 85.3071474),
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {},
                )
                : const Center(child: Text('Unable to fetch location')),
            const Positioned(
              top: 16,
              left: 4,
              child: CircleAvatar(
                backgroundColor:
                    // widget.isGarage ? AppColors.surfaceLight :
                    AppColors.softColor,
                child: BackButton(color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
