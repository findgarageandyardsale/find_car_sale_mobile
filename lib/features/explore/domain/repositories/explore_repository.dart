import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../shared/domain/models/paginated_response.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class ExploreRepository {
  Future<Either<AppException, PaginatedResponse>> fetchExplorePost({
    required int page,
    required Map<String, dynamic> filter,
  });
  Future<Either<AppException, Garageayard>> fetchDetailPost({required int? id});
}
