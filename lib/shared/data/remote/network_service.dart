import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/models/response_data.dart';
import '../../exceptions/http_exception.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, ResponseData>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, ResponseData>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });
  Future<Either<AppException, ResponseData>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  });
  Future<Either<AppException, ResponseData>> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, ResponseData>> postImage(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
