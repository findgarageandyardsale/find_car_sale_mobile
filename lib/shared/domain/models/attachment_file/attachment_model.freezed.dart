// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) {
  return _AttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$AttachmentModel {
  int? get id => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_include')
  bool? get isInclude => throw _privateConstructorUsedError;
  @JsonKey(name: 'mime_type')
  String? get mime => throw _privateConstructorUsedError;
  @JsonKey(readValue: readValueForAttachmentID)
  String? get attachment => throw _privateConstructorUsedError;

  /// Serializes this AttachmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentModelCopyWith<AttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentModelCopyWith<$Res> {
  factory $AttachmentModelCopyWith(
    AttachmentModel value,
    $Res Function(AttachmentModel) then,
  ) = _$AttachmentModelCopyWithImpl<$Res, AttachmentModel>;
  @useResult
  $Res call({
    int? id,
    String? file,
    String? thumbnail,
    String? name,
    @JsonKey(name: 'is_include') bool? isInclude,
    @JsonKey(name: 'mime_type') String? mime,
    @JsonKey(readValue: readValueForAttachmentID) String? attachment,
  });
}

/// @nodoc
class _$AttachmentModelCopyWithImpl<$Res, $Val extends AttachmentModel>
    implements $AttachmentModelCopyWith<$Res> {
  _$AttachmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? file = freezed,
    Object? thumbnail = freezed,
    Object? name = freezed,
    Object? isInclude = freezed,
    Object? mime = freezed,
    Object? attachment = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            file:
                freezed == file
                    ? _value.file
                    : file // ignore: cast_nullable_to_non_nullable
                        as String?,
            thumbnail:
                freezed == thumbnail
                    ? _value.thumbnail
                    : thumbnail // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            isInclude:
                freezed == isInclude
                    ? _value.isInclude
                    : isInclude // ignore: cast_nullable_to_non_nullable
                        as bool?,
            mime:
                freezed == mime
                    ? _value.mime
                    : mime // ignore: cast_nullable_to_non_nullable
                        as String?,
            attachment:
                freezed == attachment
                    ? _value.attachment
                    : attachment // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachmentModelImplCopyWith<$Res>
    implements $AttachmentModelCopyWith<$Res> {
  factory _$$AttachmentModelImplCopyWith(
    _$AttachmentModelImpl value,
    $Res Function(_$AttachmentModelImpl) then,
  ) = __$$AttachmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String? file,
    String? thumbnail,
    String? name,
    @JsonKey(name: 'is_include') bool? isInclude,
    @JsonKey(name: 'mime_type') String? mime,
    @JsonKey(readValue: readValueForAttachmentID) String? attachment,
  });
}

/// @nodoc
class __$$AttachmentModelImplCopyWithImpl<$Res>
    extends _$AttachmentModelCopyWithImpl<$Res, _$AttachmentModelImpl>
    implements _$$AttachmentModelImplCopyWith<$Res> {
  __$$AttachmentModelImplCopyWithImpl(
    _$AttachmentModelImpl _value,
    $Res Function(_$AttachmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? file = freezed,
    Object? thumbnail = freezed,
    Object? name = freezed,
    Object? isInclude = freezed,
    Object? mime = freezed,
    Object? attachment = freezed,
  }) {
    return _then(
      _$AttachmentModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        file:
            freezed == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                    as String?,
        thumbnail:
            freezed == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        isInclude:
            freezed == isInclude
                ? _value.isInclude
                : isInclude // ignore: cast_nullable_to_non_nullable
                    as bool?,
        mime:
            freezed == mime
                ? _value.mime
                : mime // ignore: cast_nullable_to_non_nullable
                    as String?,
        attachment:
            freezed == attachment
                ? _value.attachment
                : attachment // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentModelImpl implements _AttachmentModel {
  _$AttachmentModelImpl({
    this.id,
    this.file,
    this.thumbnail,
    this.name,
    @JsonKey(name: 'is_include') this.isInclude,
    @JsonKey(name: 'mime_type') this.mime,
    @JsonKey(readValue: readValueForAttachmentID) this.attachment,
  });

  factory _$AttachmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? file;
  @override
  final String? thumbnail;
  @override
  final String? name;
  @override
  @JsonKey(name: 'is_include')
  final bool? isInclude;
  @override
  @JsonKey(name: 'mime_type')
  final String? mime;
  @override
  @JsonKey(readValue: readValueForAttachmentID)
  final String? attachment;

  @override
  String toString() {
    return 'AttachmentModel(id: $id, file: $file, thumbnail: $thumbnail, name: $name, isInclude: $isInclude, mime: $mime, attachment: $attachment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isInclude, isInclude) ||
                other.isInclude == isInclude) &&
            (identical(other.mime, mime) || other.mime == mime) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    file,
    thumbnail,
    name,
    isInclude,
    mime,
    attachment,
  );

  /// Create a copy of AttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentModelImplCopyWith<_$AttachmentModelImpl> get copyWith =>
      __$$AttachmentModelImplCopyWithImpl<_$AttachmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentModelImplToJson(this);
  }
}

abstract class _AttachmentModel implements AttachmentModel {
  factory _AttachmentModel({
    final int? id,
    final String? file,
    final String? thumbnail,
    final String? name,
    @JsonKey(name: 'is_include') final bool? isInclude,
    @JsonKey(name: 'mime_type') final String? mime,
    @JsonKey(readValue: readValueForAttachmentID) final String? attachment,
  }) = _$AttachmentModelImpl;

  factory _AttachmentModel.fromJson(Map<String, dynamic> json) =
      _$AttachmentModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get file;
  @override
  String? get thumbnail;
  @override
  String? get name;
  @override
  @JsonKey(name: 'is_include')
  bool? get isInclude;
  @override
  @JsonKey(name: 'mime_type')
  String? get mime;
  @override
  @JsonKey(readValue: readValueForAttachmentID)
  String? get attachment;

  /// Create a copy of AttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentModelImplCopyWith<_$AttachmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
