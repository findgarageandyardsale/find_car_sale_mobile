import 'package:dartz/dartz.dart';
import 'package:findcarsale/features/explore/data/datasource/explore_remote_datasource.dart';

import 'package:findcarsale/features/explore/domain/repositories/explore_repository.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/domain/models/paginated_response.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';

class ExploreRepositoryImpl extends ExploreRepository {
  final ExploreDatasource exploreDatasource;
  ExploreRepositoryImpl(this.exploreDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchExplorePost({
    required int page,
    required Map<String, dynamic> filter,
  }) {
    return exploreDatasource.fetchPaginatedPosts(
      skip: page,
      queryParam: filter,
    );
  }

  @override
  Future<Either<AppException, Garageayard>> fetchDetailPost({
    required int? id,
  }) {
    return exploreDatasource.fetchDetailPosts(id: id);
  }
}
