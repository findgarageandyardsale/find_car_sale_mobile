// To parse this JSON data, do
//
//     final paginatedResponse = paginatedResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'paginated_response.freezed.dart';
part 'paginated_response.g.dart';

PaginatedResponse paginatedResponseFromJson(String str) => PaginatedResponse.fromJson(json.decode(str));

String paginatedResponseToJson(PaginatedResponse data) => json.encode(data.toJson());

@freezed
class PaginatedResponse with _$PaginatedResponse {
    const factory PaginatedResponse({
        int? status,
        String? message,
        Pagination? pagination,
        List? data,
    }) = _PaginatedResponse;

    factory PaginatedResponse.fromJson(Map<String, dynamic> json) => _$PaginatedResponseFromJson(json);
}


@freezed
class Pagination with _$Pagination {
    const factory Pagination({
        Links? links,
        @JsonKey(name: 'current_page') int? currentPage,
        int? total,
       @JsonKey(name: 'per_page')  int? perPage,
        @JsonKey(name: 'total_pages') int? totalPages,
    }) = _Pagination;

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}


@freezed
class Links with _$Links {
    const factory Links({
        dynamic next,
        dynamic previous,
    }) = _Links;

    factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

