import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:map_launcher/map_launcher.dart';

class AppUtils {
  /// Formats a [LocationModel] object into a readable address string.
  ///
  /// The function builds an address in the format:
  /// [Address Line][, Apt number][, Thoroughfare][, Locality][, Admin Area][ Zip Code]
  ///
  /// Each field is included only if it is not null or empty. Commas are used to
  /// separate fields appropriately, avoiding starting the output with a comma
  /// if the first field is missing.
  ///
  /// - [location]: The [LocationModel] object containing the address details.
  ///
  /// Returns: A formatted address string.
  static String formatLocationAsAddress(LocationModel location) {
    final buffer = StringBuffer();

    // Adding the address line if it's not null or empty
    if (location.addressLine != null && location.addressLine!.isNotEmpty) {
      buffer.write(location.addressLine);
    }

    // Adding the apartment number if it's not null or empty
    if (location.apartmentNumber != null &&
        location.apartmentNumber!.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(', ');
      buffer.write('Apt ${location.apartmentNumber}');
    }

    // Adding the thoroughfare (street) if it's not null or empty
    if (location.throughfare != null && location.throughfare!.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(', ');
      buffer.write(location.throughfare);
    }

    // Adding the locality (city) if it's not null or empty
    if (location.locality != null && location.locality!.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(', ');
      buffer.write(location.locality);
    }

    // Adding the administrative area (state/region) if it's not null or empty
    if (location.adminArea != null && location.adminArea!.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(', ');
      buffer.write(location.adminArea);
    }

    // Adding the zip code if it's not null or empty
    if (location.zipCode != null && location.zipCode!.isNotEmpty) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(location.zipCode);
    }

    return buffer.toString();
  }

  static void openAppDirections(double lat, double long) async {
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showDirections(destination: Coords(lat, long));
    } else {
      CustomToast.showToast('No maps installed', status: ToastStatus.error);
    }
  }
}
