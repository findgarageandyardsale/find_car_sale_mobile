// ignore_for_file: type_literal_in_constant_pattern

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart'
    as response;

import '../data/remote/network_service.dart';
import '../exceptions/http_exception.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.ResponseData>>
  handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      //

      final res = await handler();

      return Right(
        response.ResponseData(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      log(e.runtimeType.toString());
      switch (e.runtimeType) {
        case SocketException:
          e as SocketException;
          message = 'Unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at  $endpoint';
          break;

        case DioException:
          e as DioException;
          log('DioException: ${e.toString()}');
          log('Response status: ${e.response?.statusCode}');
          log('Response headers: ${e.response?.headers}');
          log('Response data: ${e.response?.data}');

          final contentType = e.response?.headers.value('content-type');
          if (e.response?.statusCode == 500) {
            message =
                'The application has encountered an unknown error.It doesn\'t appear to have affected your data, but our technical staff have been automatically notified and will be looking into this with the utmost urgency.';
            statusCode = 500;
          } else if (e.response?.statusCode == 502) {
            message = 'Bad Gateway';
            statusCode = 502;
          } else if (e.response?.statusCode == 503) {
            message = 'Service Unavailable';
            statusCode = 503;
          } else if (contentType?.contains('text/plain') == true) {
            final responseData = e.response?.data;
            if (responseData is String) {
              message = responseData;
            } else {
              message = responseData?.toString() ?? 'Internal Error occurred';
            }
          } else if (e.response?.data is Map) {
            message = e.response?.data?['message'] ?? 'Internal Error occurred';
          } else {
            message = e.response?.data?.toString() ?? 'Internal Error occurred';
          }

          statusCode = e.response?.statusCode ?? 1;
          identifier = 'DioError ${e.message} \nat  $endpoint';
          break;

        default:
          message = 'Unknown error occured';
          statusCode = 2;
          identifier = 'Unknown error ${e.toString()}\n at $endpoint';
      }
      return Left(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
