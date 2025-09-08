import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:state_notifier/state_notifier.dart';

class PolyLineNotifier extends StateNotifier<List<PointLatLng>?> {
  PolyLineNotifier() : super(null);

  Future<void> getPolyLines(LatLng origin, LatLng destination) async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult res = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(origin.latitude, origin.longitude),
          destination: PointLatLng(destination.latitude, destination.longitude),
          mode: TravelMode.driving,
        ),
        googleApiKey: '',
        // Add your Google API key here
      );

      if (res.points.isNotEmpty) {
        state = res.points;
      } else {
        state = [];
      }
    } catch (e) {
      PrintUtils.customLog(e.toString());
      state = [];
    }
  }
}
