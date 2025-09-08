import 'package:dartz/dartz.dart';

import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class FeedbackRepository {
  Future<Either<AppException, ResponseData>> createFeedback(
      {required Map<String, dynamic> map});

}
