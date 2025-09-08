import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AttachmentFileRepository {
  Future<Either<AppException, ResponseData>> uploadAttachment(
      {required FormData map});
}
