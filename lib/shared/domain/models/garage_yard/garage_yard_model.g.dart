// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage_yard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GarageayardImpl _$$GarageayardImplFromJson(
  Map<String, dynamic> json,
) => _$GarageayardImpl(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt(),
  status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
  type: $enumDecodeNullable(_$GarageYardTypeEnumMap, json['type']),
  location:
      json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  promoCode: json['promo_code'] as String?,
  transactionId: json['transaction_id'] as String?,
  availableTimeSlots:
      (json['available_time_slots'] as List<dynamic>?)
          ?.map((e) => AvailableTimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
  category:
      (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
  attachments:
      (json['images'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$GarageayardImplToJson(_$GarageayardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'status': _$StatusEnumEnumMap[instance.status],
      'type': _$GarageYardTypeEnumMap[instance.type],
      'location': instance.location,
      'promo_code': instance.promoCode,
      'transaction_id': instance.transactionId,
      'available_time_slots': instance.availableTimeSlots,
      'category': instance.category,
      'images': instance.attachments,
    };

const _$StatusEnumEnumMap = {
  StatusEnum.active: 'Active',
  StatusEnum.expired: 'Expired',
};

const _$GarageYardTypeEnumMap = {
  GarageYardType.garage: 'Garage',
  GarageYardType.yard: 'Yard',
};

_$AvailableTimeSlotImpl _$$AvailableTimeSlotImplFromJson(
  Map<String, dynamic> json,
) => _$AvailableTimeSlotImpl(
  id: (json['id'] as num?)?.toInt(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  isEditable: json['isEditable'] as bool?,
  startTime: json['start_time'] as String?,
  endTime: json['end_time'] as String?,
  garageYardId: (json['garage_yard_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$$AvailableTimeSlotImplToJson(
  _$AvailableTimeSlotImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date?.toIso8601String(),
  'isEditable': instance.isEditable,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'garage_yard_id': instance.garageYardId,
};

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      id: (json['id'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      subLocality: json['sub_locality'] as String?,
      locality: json['locality'] as String?,
      subThoroughfare: json['sub_throughfare'] as String?,
      throughfare: json['throughfare'] as String?,
      subAdminArea: json['sub_admin_area'] as String?,
      adminArea: json['admin_area'] as String?,
      addressLine: json['address_line'] as String?,
      zipCode: json['zip_code'] as String?,
      apartmentNumber: json['apartment_number'] as String?,
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'sub_locality': instance.subLocality,
      'locality': instance.locality,
      'sub_throughfare': instance.subThoroughfare,
      'throughfare': instance.throughfare,
      'sub_admin_area': instance.subAdminArea,
      'admin_area': instance.adminArea,
      'address_line': instance.addressLine,
      'zip_code': instance.zipCode,
      'apartment_number': instance.apartmentNumber,
    };
