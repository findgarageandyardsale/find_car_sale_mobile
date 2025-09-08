import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/paginated_response.dart';

import '../../../../shared/exceptions/http_exception.dart';
import '../datasource/sale_remote_datasource.dart';

abstract class SaleRepository {
  Future<Either<AppException, PaginatedResponse>> fetchExplorePost({
    required int page,
    required bool isExpired,
  });
  Future<Either<AppException, PaginatedResponse>> searchExplorePost({
    required int page,
    required String query,
  });
}

class SaleRepositoryImpl extends SaleRepository {
  final SaleDatasource exploreDatasource;
  SaleRepositoryImpl(this.exploreDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchExplorePost({
    required int page,
    required bool isExpired,
  }) {
    return exploreDatasource.fetchPaginatedPosts(
      skip: page,
      isExpired: isExpired,
    );
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchExplorePost({
    required int page,
    required String query,
  }) {
    return exploreDatasource.searchPaginatedPosts(skip: page, query: query);
  }
}
