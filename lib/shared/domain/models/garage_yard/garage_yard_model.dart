// To parse this JSON data, do
//
//     final garageayard = garageayardFromJson(jsonString);

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';

part 'garage_yard_model.freezed.dart';
part 'garage_yard_model.g.dart';

@freezed
class Garageayard with _$Garageayard {
  const factory Garageayard({
    int? id,
    String? title,
    String? description,
    int? price,
    StatusEnum? status,
    GarageYardType? type,
    LocationModel? location,
    @JsonKey(name: 'promo_code') String? promoCode,
    @JsonKey(name: 'transaction_id') String? transactionId,
    @JsonKey(name: 'available_time_slots')
    List<AvailableTimeSlot>? availableTimeSlots,
    List<Category>? category,
    @JsonKey(name: 'images') List<AttachmentModel>? attachments,
  }) = _Garageayard;

  factory Garageayard.fromJson(Map<String, dynamic> json) =>
      _$GarageayardFromJson(json);
}

// Enum for Garage
enum StatusEnum {
  @JsonValue('Active')
  active,
  @JsonValue('Expired')
  expired,
}

// Enum for GarageYardType
enum GarageYardType {
  @JsonValue('Garage')
  garage,
  @JsonValue('Yard')
  yard,
}

@freezed
class AvailableTimeSlot with _$AvailableTimeSlot {
  const factory AvailableTimeSlot({
    int? id,
    DateTime? date,
    bool? isEditable,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'garage_yard_id') int? garageYardId,
  }) = _AvailableTimeSlot;

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) =>
      _$AvailableTimeSlotFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({int? id, String? name}) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    int? id,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'sub_locality') String? subLocality,
    String? locality,
    @JsonKey(name: 'sub_throughfare') String? subThoroughfare,
    String? throughfare,
    @JsonKey(name: 'sub_admin_area') String? subAdminArea,
    @JsonKey(name: 'admin_area') String? adminArea,
    @JsonKey(name: 'address_line') String? addressLine,
    @JsonKey(name: 'zip_code') String? zipCode,
    @JsonKey(name: 'apartment_number') String? apartmentNumber,
  }) = _LocationModel;

  /*
                "id": 9,
                "latitude": 27.6588,
                "longitude": 85.3247,
                "sub_locality": "Suite 101",
                "locality": "Lalitpur",
                "sub_admin_area": null,
                "admin_area": "Bagmati Province",
                "address_line": null,
                "zip_code": "44700",
                "apartment_number": null,
                "sub_throughfare": "1234",
                "throughfare": "Jhamsikhel Rd"
                

                -------------------------------
                  "sub_locality": data['suite_apt'],
        "locality": data['city'],
        "admin_area": data['state'],
        "zip_code": data['zip_code'],
        "sub_throughfare": data['street_number'],
        "throughfare": data['street_name'],
        "latitude": data['latitude'],
        "longitude": data['longitude'],

*/
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
