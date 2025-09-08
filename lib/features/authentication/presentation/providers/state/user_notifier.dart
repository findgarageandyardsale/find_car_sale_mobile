import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/domain/models/models.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void updaetUserState({
    int? id,
    String? username,
    String? password,
    String? email,
    String? firstName,
    String? lastName,
    String? image,
    String? phoneNumber,
    String? token,
  }) {
    state = state?.copyWith(
      userId: id ?? state?.userId,
      username: username ?? state?.username,
      password: password ?? state?.password,
      email: email ?? state?.email,
      firstName: firstName ?? state?.firstName,
      lastName: lastName ?? state?.lastName,
      images: image ?? state?.images,
      phoneNumber: phoneNumber ?? state?.phoneNumber,
      token: token ?? state?.token,
    );
  }

  void updateUserAddress({
    int? id,
    double? latitude,
    double? longitude,
    String? subLocality,
    String? locality,
    String? subThroughfare,
    String? throughfare,
    String? subAdminArea,
    String? adminArea,
    String? addressLine,
    String? zipCode,
    String? apartmentNumber,
  }) {
    state = state?.copyWith(
      address: state?.address?.copyWith(
          id: id ?? state?.address?.id,
          latitude: latitude ?? state?.address?.latitude,
          longitude: longitude ?? state?.address?.longitude,
          subLocality: subLocality ?? state?.address?.subLocality,
          locality: locality ?? state?.address?.locality,
          subThoroughfare: subThroughfare ?? state?.address?.subThoroughfare,
          throughfare: throughfare ?? state?.address?.throughfare,
          subAdminArea: subAdminArea ?? state?.address?.subAdminArea,
          adminArea: adminArea ?? state?.address?.adminArea,
          addressLine: addressLine ?? state?.address?.addressLine,
          apartmentNumber: apartmentNumber ?? state?.address?.apartmentNumber,
          zipCode: zipCode ?? state?.address?.zipCode),
    );
  }
}
