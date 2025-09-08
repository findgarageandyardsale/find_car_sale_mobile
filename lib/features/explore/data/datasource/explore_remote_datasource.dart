import 'package:dartz/dartz.dart';
import 'package:findcarsale/configs/app_configs.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/models/paginated_response.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../../../../shared/globals.dart';

abstract class ExploreDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedPosts({
    required int skip,
    required Map<String, dynamic> queryParam,
  });
  Future<Either<AppException, Garageayard>> fetchDetailPosts({
    required int? id,
  });
}

class ExploreRemoteDatasource extends ExploreDatasource {
  final NetworkService networkService;
  ExploreRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedPosts({
    required int skip,
    required Map<String, dynamic> queryParam,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters.addAll(queryParam);
    queryParameters.addAll({
      'page': skip,
      'per_page': postPerPage,
      'status': 'Active',
    });
    final response = await networkService.get(
      AppConfigs.yardSaleEndpoint,
      queryParameters: queryParameters,
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'fetchPaginatedData',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = PaginatedResponse.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, Garageayard>> fetchDetailPosts({
    required int? id,
  }) async {
    final response = await networkService.get(
      '${AppConfigs.yardSaleEndpoint}$id/',
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'fetchDetailPosts',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }

      final paginatedResponse =
          jsonData is List
              ? Garageayard.fromJson(jsonData[0])
              : Garageayard.fromJson(jsonData['data'] ?? jsonData);
      return Right(paginatedResponse);
    });
  }
}
