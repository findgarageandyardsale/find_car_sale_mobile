import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';

import '../../domain/repository/feedback_repository.dart';
import '../datasource/feedback_data_source.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  final FeedbackDataSource datasource;
  FeedbackRepositoryImpl(this.datasource);
  @override
  Future<Either<AppException, ResponseData>> createFeedback({
    required Map<String, dynamic> map,
  }) {
    return datasource.postFeedback(map: map);
  }
}
