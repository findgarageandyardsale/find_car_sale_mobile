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
        ref.read(mapNotifierProvider.notifier).getUserLocation();
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
    final state = ref.watch(exploreNotifierProvider);
    final zool = ref.watch(zoomLevelState);

    // Listen to changes in exploreNotifierProvider

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
              Text('Error: ${locationState.error}', maxLines: 3),
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
