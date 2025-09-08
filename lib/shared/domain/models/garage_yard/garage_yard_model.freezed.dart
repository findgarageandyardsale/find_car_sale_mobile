// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garage_yard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Garageayard _$GarageayardFromJson(Map<String, dynamic> json) {
  return _Garageayard.fromJson(json);
}

/// @nodoc
mixin _$Garageayard {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  StatusEnum? get status => throw _privateConstructorUsedError;
  GarageYardType? get type => throw _privateConstructorUsedError;
  LocationModel? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'promo_code')
  String? get promoCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  String? get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_time_slots')
  List<AvailableTimeSlot>? get availableTimeSlots =>
      throw _privateConstructorUsedError;
  List<Category>? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'images')
  List<AttachmentModel>? get attachments => throw _privateConstructorUsedError;

  /// Serializes this Garageayard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GarageayardCopyWith<Garageayard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GarageayardCopyWith<$Res> {
  factory $GarageayardCopyWith(
    Garageayard value,
    $Res Function(Garageayard) then,
  ) = _$GarageayardCopyWithImpl<$Res, Garageayard>;
  @useResult
  $Res call({
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
  });

  $LocationModelCopyWith<$Res>? get location;
}

/// @nodoc
class _$GarageayardCopyWithImpl<$Res, $Val extends Garageayard>
    implements $GarageayardCopyWith<$Res> {
  _$GarageayardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? location = freezed,
    Object? promoCode = freezed,
    Object? transactionId = freezed,
    Object? availableTimeSlots = freezed,
    Object? category = freezed,
    Object? attachments = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            price:
                freezed == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as int?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as StatusEnum?,
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as GarageYardType?,
            location:
                freezed == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as LocationModel?,
            promoCode:
                freezed == promoCode
                    ? _value.promoCode
                    : promoCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            transactionId:
                freezed == transactionId
                    ? _value.transactionId
                    : transactionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            availableTimeSlots:
                freezed == availableTimeSlots
                    ? _value.availableTimeSlots
                    : availableTimeSlots // ignore: cast_nullable_to_non_nullable
                        as List<AvailableTimeSlot>?,
            category:
                freezed == category
                    ? _value.category
                    : category // ignore: cast_nullable_to_non_nullable
                        as List<Category>?,
            attachments:
                freezed == attachments
                    ? _value.attachments
                    : attachments // ignore: cast_nullable_to_non_nullable
                        as List<AttachmentModel>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationModelCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GarageayardImplCopyWith<$Res>
    implements $GarageayardCopyWith<$Res> {
  factory _$$GarageayardImplCopyWith(
    _$GarageayardImpl value,
    $Res Function(_$GarageayardImpl) then,
  ) = __$$GarageayardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });

  @override
  $LocationModelCopyWith<$Res>? get location;
}

/// @nodoc
class __$$GarageayardImplCopyWithImpl<$Res>
    extends _$GarageayardCopyWithImpl<$Res, _$GarageayardImpl>
    implements _$$GarageayardImplCopyWith<$Res> {
  __$$GarageayardImplCopyWithImpl(
    _$GarageayardImpl _value,
    $Res Function(_$GarageayardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? location = freezed,
    Object? promoCode = freezed,
    Object? transactionId = freezed,
    Object? availableTimeSlots = freezed,
    Object? category = freezed,
    Object? attachments = freezed,
  }) {
    return _then(
      _$GarageayardImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        price:
            freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as int?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as StatusEnum?,
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as GarageYardType?,
        location:
            freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as LocationModel?,
        promoCode:
            freezed == promoCode
                ? _value.promoCode
                : promoCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        transactionId:
            freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        availableTimeSlots:
            freezed == availableTimeSlots
                ? _value._availableTimeSlots
                : availableTimeSlots // ignore: cast_nullable_to_non_nullable
                    as List<AvailableTimeSlot>?,
        category:
            freezed == category
                ? _value._category
                : category // ignore: cast_nullable_to_non_nullable
                    as List<Category>?,
        attachments:
            freezed == attachments
                ? _value._attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                    as List<AttachmentModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GarageayardImpl with DiagnosticableTreeMixin implements _Garageayard {
  const _$GarageayardImpl({
    this.id,
    this.title,
    this.description,
    this.price,
    this.status,
    this.type,
    this.location,
    @JsonKey(name: 'promo_code') this.promoCode,
    @JsonKey(name: 'transaction_id') this.transactionId,
    @JsonKey(name: 'available_time_slots')
    final List<AvailableTimeSlot>? availableTimeSlots,
    final List<Category>? category,
    @JsonKey(name: 'images') final List<AttachmentModel>? attachments,
  }) : _availableTimeSlots = availableTimeSlots,
       _category = category,
       _attachments = attachments;

  factory _$GarageayardImpl.fromJson(Map<String, dynamic> json) =>
      _$$GarageayardImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? price;
  @override
  final StatusEnum? status;
  @override
  final GarageYardType? type;
  @override
  final LocationModel? location;
  @override
  @JsonKey(name: 'promo_code')
  final String? promoCode;
  @override
  @JsonKey(name: 'transaction_id')
  final String? transactionId;
  final List<AvailableTimeSlot>? _availableTimeSlots;
  @override
  @JsonKey(name: 'available_time_slots')
  List<AvailableTimeSlot>? get availableTimeSlots {
    final value = _availableTimeSlots;
    if (value == null) return null;
    if (_availableTimeSlots is EqualUnmodifiableListView)
      return _availableTimeSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Category>? _category;
  @override
  List<Category>? get category {
    final value = _category;
    if (value == null) return null;
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AttachmentModel>? _attachments;
  @override
  @JsonKey(name: 'images')
  List<AttachmentModel>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Garageayard(id: $id, title: $title, description: $description, price: $price, status: $status, type: $type, location: $location, promoCode: $promoCode, transactionId: $transactionId, availableTimeSlots: $availableTimeSlots, category: $category, attachments: $attachments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Garageayard'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('promoCode', promoCode))
      ..add(DiagnosticsProperty('transactionId', transactionId))
      ..add(DiagnosticsProperty('availableTimeSlots', availableTimeSlots))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('attachments', attachments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GarageayardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.promoCode, promoCode) ||
                other.promoCode == promoCode) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            const DeepCollectionEquality().equals(
              other._availableTimeSlots,
              _availableTimeSlots,
            ) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    price,
    status,
    type,
    location,
    promoCode,
    transactionId,
    const DeepCollectionEquality().hash(_availableTimeSlots),
    const DeepCollectionEquality().hash(_category),
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GarageayardImplCopyWith<_$GarageayardImpl> get copyWith =>
      __$$GarageayardImplCopyWithImpl<_$GarageayardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GarageayardImplToJson(this);
  }
}

abstract class _Garageayard implements Garageayard {
  const factory _Garageayard({
    final int? id,
    final String? title,
    final String? description,
    final int? price,
    final StatusEnum? status,
    final GarageYardType? type,
    final LocationModel? location,
    @JsonKey(name: 'promo_code') final String? promoCode,
    @JsonKey(name: 'transaction_id') final String? transactionId,
    @JsonKey(name: 'available_time_slots')
    final List<AvailableTimeSlot>? availableTimeSlots,
    final List<Category>? category,
    @JsonKey(name: 'images') final List<AttachmentModel>? attachments,
  }) = _$GarageayardImpl;

  factory _Garageayard.fromJson(Map<String, dynamic> json) =
      _$GarageayardImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  int? get price;
  @override
  StatusEnum? get status;
  @override
  GarageYardType? get type;
  @override
  LocationModel? get location;
  @override
  @JsonKey(name: 'promo_code')
  String? get promoCode;
  @override
  @JsonKey(name: 'transaction_id')
  String? get transactionId;
  @override
  @JsonKey(name: 'available_time_slots')
  List<AvailableTimeSlot>? get availableTimeSlots;
  @override
  List<Category>? get category;
  @override
  @JsonKey(name: 'images')
  List<AttachmentModel>? get attachments;

  /// Create a copy of Garageayard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GarageayardImplCopyWith<_$GarageayardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvailableTimeSlot _$AvailableTimeSlotFromJson(Map<String, dynamic> json) {
  return _AvailableTimeSlot.fromJson(json);
}

/// @nodoc
mixin _$AvailableTimeSlot {
  int? get id => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  bool? get isEditable => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'garage_yard_id')
  int? get garageYardId => throw _privateConstructorUsedError;

  /// Serializes this AvailableTimeSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableTimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableTimeSlotCopyWith<AvailableTimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableTimeSlotCopyWith<$Res> {
  factory $AvailableTimeSlotCopyWith(
    AvailableTimeSlot value,
    $Res Function(AvailableTimeSlot) then,
  ) = _$AvailableTimeSlotCopyWithImpl<$Res, AvailableTimeSlot>;
  @useResult
  $Res call({
    int? id,
    DateTime? date,
    bool? isEditable,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'garage_yard_id') int? garageYardId,
  });
}

/// @nodoc
class _$AvailableTimeSlotCopyWithImpl<$Res, $Val extends AvailableTimeSlot>
    implements $AvailableTimeSlotCopyWith<$Res> {
  _$AvailableTimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableTimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? isEditable = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? garageYardId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            date:
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isEditable:
                freezed == isEditable
                    ? _value.isEditable
                    : isEditable // ignore: cast_nullable_to_non_nullable
                        as bool?,
            startTime:
                freezed == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            endTime:
                freezed == endTime
                    ? _value.endTime
                    : endTime // ignore: cast_nullable_to_non_nullable
                        as String?,
            garageYardId:
                freezed == garageYardId
                    ? _value.garageYardId
                    : garageYardId // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableTimeSlotImplCopyWith<$Res>
    implements $AvailableTimeSlotCopyWith<$Res> {
  factory _$$AvailableTimeSlotImplCopyWith(
    _$AvailableTimeSlotImpl value,
    $Res Function(_$AvailableTimeSlotImpl) then,
  ) = __$$AvailableTimeSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    DateTime? date,
    bool? isEditable,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
    @JsonKey(name: 'garage_yard_id') int? garageYardId,
  });
}

/// @nodoc
class __$$AvailableTimeSlotImplCopyWithImpl<$Res>
    extends _$AvailableTimeSlotCopyWithImpl<$Res, _$AvailableTimeSlotImpl>
    implements _$$AvailableTimeSlotImplCopyWith<$Res> {
  __$$AvailableTimeSlotImplCopyWithImpl(
    _$AvailableTimeSlotImpl _value,
    $Res Function(_$AvailableTimeSlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableTimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? isEditable = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? garageYardId = freezed,
  }) {
    return _then(
      _$AvailableTimeSlotImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        date:
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isEditable:
            freezed == isEditable
                ? _value.isEditable
                : isEditable // ignore: cast_nullable_to_non_nullable
                    as bool?,
        startTime:
            freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        endTime:
            freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                    as String?,
        garageYardId:
            freezed == garageYardId
                ? _value.garageYardId
                : garageYardId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableTimeSlotImpl
    with DiagnosticableTreeMixin
    implements _AvailableTimeSlot {
  const _$AvailableTimeSlotImpl({
    this.id,
    this.date,
    this.isEditable,
    @JsonKey(name: 'start_time') this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
    @JsonKey(name: 'garage_yard_id') this.garageYardId,
  });

  factory _$AvailableTimeSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableTimeSlotImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime? date;
  @override
  final bool? isEditable;
  @override
  @JsonKey(name: 'start_time')
  final String? startTime;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;
  @override
  @JsonKey(name: 'garage_yard_id')
  final int? garageYardId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AvailableTimeSlot(id: $id, date: $date, isEditable: $isEditable, startTime: $startTime, endTime: $endTime, garageYardId: $garageYardId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AvailableTimeSlot'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('isEditable', isEditable))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('garageYardId', garageYardId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableTimeSlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isEditable, isEditable) ||
                other.isEditable == isEditable) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.garageYardId, garageYardId) ||
                other.garageYardId == garageYardId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    isEditable,
    startTime,
    endTime,
    garageYardId,
  );

  /// Create a copy of AvailableTimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableTimeSlotImplCopyWith<_$AvailableTimeSlotImpl> get copyWith =>
      __$$AvailableTimeSlotImplCopyWithImpl<_$AvailableTimeSlotImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableTimeSlotImplToJson(this);
  }
}

abstract class _AvailableTimeSlot implements AvailableTimeSlot {
  const factory _AvailableTimeSlot({
    final int? id,
    final DateTime? date,
    final bool? isEditable,
    @JsonKey(name: 'start_time') final String? startTime,
    @JsonKey(name: 'end_time') final String? endTime,
    @JsonKey(name: 'garage_yard_id') final int? garageYardId,
  }) = _$AvailableTimeSlotImpl;

  factory _AvailableTimeSlot.fromJson(Map<String, dynamic> json) =
      _$AvailableTimeSlotImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime? get date;
  @override
  bool? get isEditable;
  @override
  @JsonKey(name: 'start_time')
  String? get startTime;
  @override
  @JsonKey(name: 'end_time')
  String? get endTime;
  @override
  @JsonKey(name: 'garage_yard_id')
  int? get garageYardId;

  /// Create a copy of AvailableTimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableTimeSlotImplCopyWith<_$AvailableTimeSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this Category to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? name = freezed}) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? name = freezed}) {
    return _then(
      _$CategoryImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl with DiagnosticableTreeMixin implements _Category {
  const _$CategoryImpl({this.id, this.name});

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Category(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Category'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(this);
  }
}

abstract class _Category implements Category {
  const factory _Category({final int? id, final String? name}) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return _LocationModel.fromJson(json);
}

/// @nodoc
mixin _$LocationModel {
  int? get id => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_locality')
  String? get subLocality => throw _privateConstructorUsedError;
  String? get locality => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_throughfare')
  String? get subThoroughfare => throw _privateConstructorUsedError;
  String? get throughfare => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_admin_area')
  String? get subAdminArea => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_area')
  String? get adminArea => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_line')
  String? get addressLine => throw _privateConstructorUsedError;
  @JsonKey(name: 'zip_code')
  String? get zipCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'apartment_number')
  String? get apartmentNumber => throw _privateConstructorUsedError;

  /// Serializes this LocationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationModelCopyWith<LocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModelCopyWith<$Res> {
  factory $LocationModelCopyWith(
    LocationModel value,
    $Res Function(LocationModel) then,
  ) = _$LocationModelCopyWithImpl<$Res, LocationModel>;
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class _$LocationModelCopyWithImpl<$Res, $Val extends LocationModel>
    implements $LocationModelCopyWith<$Res> {
  _$LocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? subLocality = freezed,
    Object? locality = freezed,
    Object? subThoroughfare = freezed,
    Object? throughfare = freezed,
    Object? subAdminArea = freezed,
    Object? adminArea = freezed,
    Object? addressLine = freezed,
    Object? zipCode = freezed,
    Object? apartmentNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            latitude:
                freezed == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            longitude:
                freezed == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            subLocality:
                freezed == subLocality
                    ? _value.subLocality
                    : subLocality // ignore: cast_nullable_to_non_nullable
                        as String?,
            locality:
                freezed == locality
                    ? _value.locality
                    : locality // ignore: cast_nullable_to_non_nullable
                        as String?,
            subThoroughfare:
                freezed == subThoroughfare
                    ? _value.subThoroughfare
                    : subThoroughfare // ignore: cast_nullable_to_non_nullable
                        as String?,
            throughfare:
                freezed == throughfare
                    ? _value.throughfare
                    : throughfare // ignore: cast_nullable_to_non_nullable
                        as String?,
            subAdminArea:
                freezed == subAdminArea
                    ? _value.subAdminArea
                    : subAdminArea // ignore: cast_nullable_to_non_nullable
                        as String?,
            adminArea:
                freezed == adminArea
                    ? _value.adminArea
                    : adminArea // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressLine:
                freezed == addressLine
                    ? _value.addressLine
                    : addressLine // ignore: cast_nullable_to_non_nullable
                        as String?,
            zipCode:
                freezed == zipCode
                    ? _value.zipCode
                    : zipCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            apartmentNumber:
                freezed == apartmentNumber
                    ? _value.apartmentNumber
                    : apartmentNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationModelImplCopyWith<$Res>
    implements $LocationModelCopyWith<$Res> {
  factory _$$LocationModelImplCopyWith(
    _$LocationModelImpl value,
    $Res Function(_$LocationModelImpl) then,
  ) = __$$LocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class __$$LocationModelImplCopyWithImpl<$Res>
    extends _$LocationModelCopyWithImpl<$Res, _$LocationModelImpl>
    implements _$$LocationModelImplCopyWith<$Res> {
  __$$LocationModelImplCopyWithImpl(
    _$LocationModelImpl _value,
    $Res Function(_$LocationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? subLocality = freezed,
    Object? locality = freezed,
    Object? subThoroughfare = freezed,
    Object? throughfare = freezed,
    Object? subAdminArea = freezed,
    Object? adminArea = freezed,
    Object? addressLine = freezed,
    Object? zipCode = freezed,
    Object? apartmentNumber = freezed,
  }) {
    return _then(
      _$LocationModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        latitude:
            freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        longitude:
            freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        subLocality:
            freezed == subLocality
                ? _value.subLocality
                : subLocality // ignore: cast_nullable_to_non_nullable
                    as String?,
        locality:
            freezed == locality
                ? _value.locality
                : locality // ignore: cast_nullable_to_non_nullable
                    as String?,
        subThoroughfare:
            freezed == subThoroughfare
                ? _value.subThoroughfare
                : subThoroughfare // ignore: cast_nullable_to_non_nullable
                    as String?,
        throughfare:
            freezed == throughfare
                ? _value.throughfare
                : throughfare // ignore: cast_nullable_to_non_nullable
                    as String?,
        subAdminArea:
            freezed == subAdminArea
                ? _value.subAdminArea
                : subAdminArea // ignore: cast_nullable_to_non_nullable
                    as String?,
        adminArea:
            freezed == adminArea
                ? _value.adminArea
                : adminArea // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressLine:
            freezed == addressLine
                ? _value.addressLine
                : addressLine // ignore: cast_nullable_to_non_nullable
                    as String?,
        zipCode:
            freezed == zipCode
                ? _value.zipCode
                : zipCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        apartmentNumber:
            freezed == apartmentNumber
                ? _value.apartmentNumber
                : apartmentNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationModelImpl
    with DiagnosticableTreeMixin
    implements _LocationModel {
  const _$LocationModelImpl({
    this.id,
    this.latitude,
    this.longitude,
    @JsonKey(name: 'sub_locality') this.subLocality,
    this.locality,
    @JsonKey(name: 'sub_throughfare') this.subThoroughfare,
    this.throughfare,
    @JsonKey(name: 'sub_admin_area') this.subAdminArea,
    @JsonKey(name: 'admin_area') this.adminArea,
    @JsonKey(name: 'address_line') this.addressLine,
    @JsonKey(name: 'zip_code') this.zipCode,
    @JsonKey(name: 'apartment_number') this.apartmentNumber,
  });

  factory _$LocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationModelImplFromJson(json);

  @override
  final int? id;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'sub_locality')
  final String? subLocality;
  @override
  final String? locality;
  @override
  @JsonKey(name: 'sub_throughfare')
  final String? subThoroughfare;
  @override
  final String? throughfare;
  @override
  @JsonKey(name: 'sub_admin_area')
  final String? subAdminArea;
  @override
  @JsonKey(name: 'admin_area')
  final String? adminArea;
  @override
  @JsonKey(name: 'address_line')
  final String? addressLine;
  @override
  @JsonKey(name: 'zip_code')
  final String? zipCode;
  @override
  @JsonKey(name: 'apartment_number')
  final String? apartmentNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationModel(id: $id, latitude: $latitude, longitude: $longitude, subLocality: $subLocality, locality: $locality, subThoroughfare: $subThoroughfare, throughfare: $throughfare, subAdminArea: $subAdminArea, adminArea: $adminArea, addressLine: $addressLine, zipCode: $zipCode, apartmentNumber: $apartmentNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('subLocality', subLocality))
      ..add(DiagnosticsProperty('locality', locality))
      ..add(DiagnosticsProperty('subThoroughfare', subThoroughfare))
      ..add(DiagnosticsProperty('throughfare', throughfare))
      ..add(DiagnosticsProperty('subAdminArea', subAdminArea))
      ..add(DiagnosticsProperty('adminArea', adminArea))
      ..add(DiagnosticsProperty('addressLine', addressLine))
      ..add(DiagnosticsProperty('zipCode', zipCode))
      ..add(DiagnosticsProperty('apartmentNumber', apartmentNumber));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.subLocality, subLocality) ||
                other.subLocality == subLocality) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.subThoroughfare, subThoroughfare) ||
                other.subThoroughfare == subThoroughfare) &&
            (identical(other.throughfare, throughfare) ||
                other.throughfare == throughfare) &&
            (identical(other.subAdminArea, subAdminArea) ||
                other.subAdminArea == subAdminArea) &&
            (identical(other.adminArea, adminArea) ||
                other.adminArea == adminArea) &&
            (identical(other.addressLine, addressLine) ||
                other.addressLine == addressLine) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.apartmentNumber, apartmentNumber) ||
                other.apartmentNumber == apartmentNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    latitude,
    longitude,
    subLocality,
    locality,
    subThoroughfare,
    throughfare,
    subAdminArea,
    adminArea,
    addressLine,
    zipCode,
    apartmentNumber,
  );

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      __$$LocationModelImplCopyWithImpl<_$LocationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationModelImplToJson(this);
  }
}

abstract class _LocationModel implements LocationModel {
  const factory _LocationModel({
    final int? id,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'sub_locality') final String? subLocality,
    final String? locality,
    @JsonKey(name: 'sub_throughfare') final String? subThoroughfare,
    final String? throughfare,
    @JsonKey(name: 'sub_admin_area') final String? subAdminArea,
    @JsonKey(name: 'admin_area') final String? adminArea,
    @JsonKey(name: 'address_line') final String? addressLine,
    @JsonKey(name: 'zip_code') final String? zipCode,
    @JsonKey(name: 'apartment_number') final String? apartmentNumber,
  }) = _$LocationModelImpl;

  factory _LocationModel.fromJson(Map<String, dynamic> json) =
      _$LocationModelImpl.fromJson;

  @override
  int? get id;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'sub_locality')
  String? get subLocality;
  @override
  String? get locality;
  @override
  @JsonKey(name: 'sub_throughfare')
  String? get subThoroughfare;
  @override
  String? get throughfare;
  @override
  @JsonKey(name: 'sub_admin_area')
  String? get subAdminArea;
  @override
  @JsonKey(name: 'admin_area')
  String? get adminArea;
  @override
  @JsonKey(name: 'address_line')
  String? get addressLine;
  @override
  @JsonKey(name: 'zip_code')
  String? get zipCode;
  @override
  @JsonKey(name: 'apartment_number')
  String? get apartmentNumber;

  /// Create a copy of LocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
