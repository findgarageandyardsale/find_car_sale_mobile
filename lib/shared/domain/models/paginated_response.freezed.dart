// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedResponse _$PaginatedResponseFromJson(Map<String, dynamic> json) {
  return _PaginatedResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedResponse {
  int? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;
  List<dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this PaginatedResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedResponseCopyWith<PaginatedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedResponseCopyWith<$Res> {
  factory $PaginatedResponseCopyWith(
    PaginatedResponse value,
    $Res Function(PaginatedResponse) then,
  ) = _$PaginatedResponseCopyWithImpl<$Res, PaginatedResponse>;
  @useResult
  $Res call({
    int? status,
    String? message,
    Pagination? pagination,
    List<dynamic>? data,
  });

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$PaginatedResponseCopyWithImpl<$Res, $Val extends PaginatedResponse>
    implements $PaginatedResponseCopyWith<$Res> {
  _$PaginatedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? pagination = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as int?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            pagination:
                freezed == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination?,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<dynamic>?,
          )
          as $Val,
    );
  }

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginatedResponseImplCopyWith<$Res>
    implements $PaginatedResponseCopyWith<$Res> {
  factory _$$PaginatedResponseImplCopyWith(
    _$PaginatedResponseImpl value,
    $Res Function(_$PaginatedResponseImpl) then,
  ) = __$$PaginatedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? status,
    String? message,
    Pagination? pagination,
    List<dynamic>? data,
  });

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$PaginatedResponseImplCopyWithImpl<$Res>
    extends _$PaginatedResponseCopyWithImpl<$Res, _$PaginatedResponseImpl>
    implements _$$PaginatedResponseImplCopyWith<$Res> {
  __$$PaginatedResponseImplCopyWithImpl(
    _$PaginatedResponseImpl _value,
    $Res Function(_$PaginatedResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? message = freezed,
    Object? pagination = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _$PaginatedResponseImpl(
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as int?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        pagination:
            freezed == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination?,
        data:
            freezed == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedResponseImpl implements _PaginatedResponse {
  const _$PaginatedResponseImpl({
    this.status,
    this.message,
    this.pagination,
    final List<dynamic>? data,
  }) : _data = data;

  factory _$PaginatedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedResponseImplFromJson(json);

  @override
  final int? status;
  @override
  final String? message;
  @override
  final Pagination? pagination;
  final List<dynamic>? _data;
  @override
  List<dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PaginatedResponse(status: $status, message: $message, pagination: $pagination, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    pagination,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedResponseImplCopyWith<_$PaginatedResponseImpl> get copyWith =>
      __$$PaginatedResponseImplCopyWithImpl<_$PaginatedResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedResponseImplToJson(this);
  }
}

abstract class _PaginatedResponse implements PaginatedResponse {
  const factory _PaginatedResponse({
    final int? status,
    final String? message,
    final Pagination? pagination,
    final List<dynamic>? data,
  }) = _$PaginatedResponseImpl;

  factory _PaginatedResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedResponseImpl.fromJson;

  @override
  int? get status;
  @override
  String? get message;
  @override
  Pagination? get pagination;
  @override
  List<dynamic>? get data;

  /// Create a copy of PaginatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedResponseImplCopyWith<_$PaginatedResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  Links? get links => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int? get totalPages => throw _privateConstructorUsedError;

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
    Pagination value,
    $Res Function(Pagination) then,
  ) = _$PaginationCopyWithImpl<$Res, Pagination>;
  @useResult
  $Res call({
    Links? links,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_pages') int? totalPages,
  });

  $LinksCopyWith<$Res>? get links;
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res, $Val extends Pagination>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = freezed,
    Object? currentPage = freezed,
    Object? total = freezed,
    Object? perPage = freezed,
    Object? totalPages = freezed,
  }) {
    return _then(
      _value.copyWith(
            links:
                freezed == links
                    ? _value.links
                    : links // ignore: cast_nullable_to_non_nullable
                        as Links?,
            currentPage:
                freezed == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int?,
            total:
                freezed == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int?,
            perPage:
                freezed == perPage
                    ? _value.perPage
                    : perPage // ignore: cast_nullable_to_non_nullable
                        as int?,
            totalPages:
                freezed == totalPages
                    ? _value.totalPages
                    : totalPages // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinksCopyWith<$Res>? get links {
    if (_value.links == null) {
      return null;
    }

    return $LinksCopyWith<$Res>(_value.links!, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaginationImplCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$PaginationImplCopyWith(
    _$PaginationImpl value,
    $Res Function(_$PaginationImpl) then,
  ) = __$$PaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Links? links,
    @JsonKey(name: 'current_page') int? currentPage,
    int? total,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'total_pages') int? totalPages,
  });

  @override
  $LinksCopyWith<$Res>? get links;
}

/// @nodoc
class __$$PaginationImplCopyWithImpl<$Res>
    extends _$PaginationCopyWithImpl<$Res, _$PaginationImpl>
    implements _$$PaginationImplCopyWith<$Res> {
  __$$PaginationImplCopyWithImpl(
    _$PaginationImpl _value,
    $Res Function(_$PaginationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = freezed,
    Object? currentPage = freezed,
    Object? total = freezed,
    Object? perPage = freezed,
    Object? totalPages = freezed,
  }) {
    return _then(
      _$PaginationImpl(
        links:
            freezed == links
                ? _value.links
                : links // ignore: cast_nullable_to_non_nullable
                    as Links?,
        currentPage:
            freezed == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int?,
        total:
            freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int?,
        perPage:
            freezed == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                    as int?,
        totalPages:
            freezed == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationImpl implements _Pagination {
  const _$PaginationImpl({
    this.links,
    @JsonKey(name: 'current_page') this.currentPage,
    this.total,
    @JsonKey(name: 'per_page') this.perPage,
    @JsonKey(name: 'total_pages') this.totalPages,
  });

  factory _$PaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationImplFromJson(json);

  @override
  final Links? links;
  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @override
  final int? total;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;
  @override
  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @override
  String toString() {
    return 'Pagination(links: $links, currentPage: $currentPage, total: $total, perPage: $perPage, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationImpl &&
            (identical(other.links, links) || other.links == links) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, links, currentPage, total, perPage, totalPages);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      __$$PaginationImplCopyWithImpl<_$PaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationImplToJson(this);
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination({
    final Links? links,
    @JsonKey(name: 'current_page') final int? currentPage,
    final int? total,
    @JsonKey(name: 'per_page') final int? perPage,
    @JsonKey(name: 'total_pages') final int? totalPages,
  }) = _$PaginationImpl;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$PaginationImpl.fromJson;

  @override
  Links? get links;
  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  int? get total;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  @JsonKey(name: 'total_pages')
  int? get totalPages;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Links _$LinksFromJson(Map<String, dynamic> json) {
  return _Links.fromJson(json);
}

/// @nodoc
mixin _$Links {
  dynamic get next => throw _privateConstructorUsedError;
  dynamic get previous => throw _privateConstructorUsedError;

  /// Serializes this Links to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Links
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinksCopyWith<Links> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksCopyWith<$Res> {
  factory $LinksCopyWith(Links value, $Res Function(Links) then) =
      _$LinksCopyWithImpl<$Res, Links>;
  @useResult
  $Res call({dynamic next, dynamic previous});
}

/// @nodoc
class _$LinksCopyWithImpl<$Res, $Val extends Links>
    implements $LinksCopyWith<$Res> {
  _$LinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Links
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? next = freezed, Object? previous = freezed}) {
    return _then(
      _value.copyWith(
            next:
                freezed == next
                    ? _value.next
                    : next // ignore: cast_nullable_to_non_nullable
                        as dynamic,
            previous:
                freezed == previous
                    ? _value.previous
                    : previous // ignore: cast_nullable_to_non_nullable
                        as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LinksImplCopyWith<$Res> implements $LinksCopyWith<$Res> {
  factory _$$LinksImplCopyWith(
    _$LinksImpl value,
    $Res Function(_$LinksImpl) then,
  ) = __$$LinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic next, dynamic previous});
}

/// @nodoc
class __$$LinksImplCopyWithImpl<$Res>
    extends _$LinksCopyWithImpl<$Res, _$LinksImpl>
    implements _$$LinksImplCopyWith<$Res> {
  __$$LinksImplCopyWithImpl(
    _$LinksImpl _value,
    $Res Function(_$LinksImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Links
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? next = freezed, Object? previous = freezed}) {
    return _then(
      _$LinksImpl(
        next:
            freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        previous:
            freezed == previous
                ? _value.previous
                : previous // ignore: cast_nullable_to_non_nullable
                    as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LinksImpl implements _Links {
  const _$LinksImpl({this.next, this.previous});

  factory _$LinksImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinksImplFromJson(json);

  @override
  final dynamic next;
  @override
  final dynamic previous;

  @override
  String toString() {
    return 'Links(next: $next, previous: $previous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinksImpl &&
            const DeepCollectionEquality().equals(other.next, next) &&
            const DeepCollectionEquality().equals(other.previous, previous));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(next),
    const DeepCollectionEquality().hash(previous),
  );

  /// Create a copy of Links
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinksImplCopyWith<_$LinksImpl> get copyWith =>
      __$$LinksImplCopyWithImpl<_$LinksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinksImplToJson(this);
  }
}

abstract class _Links implements Links {
  const factory _Links({final dynamic next, final dynamic previous}) =
      _$LinksImpl;

  factory _Links.fromJson(Map<String, dynamic> json) = _$LinksImpl.fromJson;

  @override
  dynamic get next;
  @override
  dynamic get previous;

  /// Create a copy of Links
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinksImplCopyWith<_$LinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
