import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ployline_notifier.dart';

final polyLineNotifierProvider = StateNotifierProvider<PolyLineNotifier, List<PointLatLng>?>(
  (ref) {
    return PolyLineNotifier();
  },
);