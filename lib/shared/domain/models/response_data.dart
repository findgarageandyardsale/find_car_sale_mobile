import 'package:dartz/dartz.dart';
import '../../exceptions/http_exception.dart';

class ResponseData {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  ResponseData(
      {required this.statusCode, this.statusMessage, this.data = const {}});
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }

  // Factory constructor to create a Response object from a JSON map
  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      statusCode: json['statys'] ?? 0,
      statusMessage: json['nessage'],
      data: json['data'] ?? {},
    );
  }
}

extension ResponseExtension on ResponseData {
  Right<AppException, ResponseData> get toRight => Right(this);
}
