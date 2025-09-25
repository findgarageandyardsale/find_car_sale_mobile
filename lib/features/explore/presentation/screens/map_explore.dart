import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/post_single_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../services/location_service/presentation/map_notifier_provider.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/widgets/custom_toast.dart';
import '../providers/explore_state_provider.dart';

class MapExplore extends ConsumerStatefulWidget {
  const MapExplore({super.key});

  @override
  ConsumerState<MapExplore> createState() => _MapExploreState();
}

class _MapExploreState extends ConsumerState<MapExplore> {
  bool onTap = false;
  Garageayard? tapModel;
  BitmapDescriptor? garageIcon;
  @override
  void initState() {
    super.initState();
    recall();
    _loadMarkerIcons();
  }

  void recall() {
    Future.microtask(() {
      final locationState = ref.watch(mapNotifierProvider);

      if (locationState.error != null) {
        ref.read(mapNotifierProvider.notifier).retryGetLocation();
      }
    });
  }

  markerOnTap() {
    setState(() {
      onTap = !onTap;
    });
  }

  Future<void> _loadMarkerIcons() async {
    garageIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(16, 26)),
      'assets/garage.png',
    );
    setState(() {}); // Update the UI once icons are loaded
  }

  setGarageAndTap(Garageayard? model) {
    if (onTap == true) {
      markerOnTap();
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      tapModel = model;
      markerOnTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(mapNotifierProvider);
    final state = ref.watch(mapExploreNotifierProvider);
    final zool = ref.watch(zoomLevelState);

    // Initialize map explore data when location is available
    ref.watch(mapExploreInitializerProvider);

    Set<Marker> markers = <Marker>{};
    try {
      for (var element in state.garageYardList) {
        if (element.location?.latitude != null &&
            element.location?.longitude != null) {
          // Load the custom marker from assets

          markers.add(
            Marker(
              markerId: MarkerId('${element.id}'),
              position: LatLng(
                element.location!.latitude!,
                element.location!.longitude!,
              ),
              onTap: () => setGarageAndTap(element),
              icon: garageIcon ?? BitmapDescriptor.defaultMarker,
            ),
          );
        }
      }
    } catch (e) {
      PrintUtils.customLog("Error in markers: $e");
    }

    return locationState.isLoading
        ? const Center(child: CircularProgressIndicator())
        : locationState.error != null
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
              Spacing.sizedBoxH_16(),
              Text(
                'Location Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Spacing.sizedBoxH_08(),
              Text(
                locationState.error!,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacing.sizedBoxH_24(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(mapNotifierProvider.notifier).retryGetLocation();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Request location permission first
                      PermissionStatus status =
                          await Permission.location.request();

                      if (status.isDenied || status.isPermanentlyDenied) {
                        // Open app settings for location permission
                        bool opened = await openAppSettings();
                        if (!opened) {
                          CustomToast.showToast(
                            "Failed to open settings",
                            status: ToastStatus.error,
                          );
                        }
                      } else if (status.isGranted) {
                        // Permission granted, retry location
                        ref
                            .read(mapNotifierProvider.notifier)
                            .retryGetLocation();
                      }
                    },
                    icon: const Icon(Icons.location_on),
                    label: const Text('Location Settings'),
                  ),
                ],
              ),
            ],
          ),
        )
        : locationState.currentLatLng != null
        ? Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target:
                    // markers.isEmpty
                    //     ?
                    locationState.currentLatLng!,
                // : markers.first.position,

                ///set this to inital marker
                zoom: zool,

                ///zoom level
              ),
              onMapCreated: (GoogleMapController controller) {
                // ref.read(mapControllerState.notifier).state =
                //     controller;
              },
              markers: markers,
            ),
            if (onTap)
              Positioned(
                top: 16,
                left: 16,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 32,
                  child: PostSingleItem(
                    fromMap: true,
                    singlePost: tapModel ?? const Garageayard(),
                    onTap: () => markerOnTap(),
                  ),
                ),
              ),
          ],
        )
        : const Center(child: Text('Unable to fetch location'));
  }
}
