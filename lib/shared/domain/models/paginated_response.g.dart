// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedResponseImpl _$$PaginatedResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedResponseImpl(
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  data: json['data'] as List<dynamic>?,
);

Map<String, dynamic> _$$PaginatedResponseImplToJson(
  _$PaginatedResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'pagination': instance.pagination,
  'data': instance.data,
};

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      links:
          json['links'] == null
              ? null
              : Links.fromJson(json['links'] as Map<String, dynamic>),
      currentPage: (json['current_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'links': instance.links,
      'current_page': instance.currentPage,
      'total': instance.total,
      'per_page': instance.perPage,
      'total_pages': instance.totalPages,
    };

_$LinksImpl _$$LinksImplFromJson(Map<String, dynamic> json) =>
    _$LinksImpl(next: json['next'], previous: json['previous']);

Map<String, dynamic> _$$LinksImplToJson(_$LinksImpl instance) =>
    <String, dynamic>{'next': instance.next, 'previous': instance.previous};
