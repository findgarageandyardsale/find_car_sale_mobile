import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  /// Earth's radius in meters
  static const double earthRadius = 6371000.0;

  /// Half mile in meters (0.5 * 1609.344)
  static const double halfMileInMeters =
      500.0; // Reduced from 804.672 to 500 meters

  /// Creates a circle around a center point with a specified radius in meters
  /// Returns a list of LatLng points that form a circle
  static List<LatLng> createCirclePoints(
    LatLng center,
    double radiusInMeters, {
    int points = 64,
  }) {
    List<LatLng> circlePoints = [];

    for (int i = 0; i < points; i++) {
      double angle = (2 * pi * i) / points;

      // Calculate the offset in meters
      double x = radiusInMeters * cos(angle);
      double y = radiusInMeters * sin(angle);

      // Convert offset to lat/lng
      double lat = center.latitude + (y / earthRadius) * (180 / pi);
      double lng =
          center.longitude +
          (x / earthRadius) * (180 / pi) / cos(center.latitude * pi / 180);

      circlePoints.add(LatLng(lat, lng));
    }

    return circlePoints;
  }

  /// Creates a circle with half-mile radius
  static List<LatLng> createHalfMileCircle(LatLng center, {int points = 64}) {
    return createCirclePoints(center, halfMileInMeters, points: points);
  }

  /// Creates a circle with quarter-mile radius
  static List<LatLng> createQuarterMileCircle(
    LatLng center, {
    int points = 64,
  }) {
    return createCirclePoints(center, halfMileInMeters / 2, points: points);
  }

  /// Creates a circle with one-mile radius
  static List<LatLng> createOneMileCircle(LatLng center, {int points = 64}) {
    return createCirclePoints(center, halfMileInMeters * 2, points: points);
  }
}
