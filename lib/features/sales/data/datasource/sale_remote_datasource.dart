import 'package:dartz/dartz.dart';
import 'package:findcarsale/configs/app_configs.dart';

import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/models/paginated_response.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../../../../shared/globals.dart';

abstract class SaleDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedPosts({
    required int skip,
    required bool isExpired,
  });
  Future<Either<AppException, PaginatedResponse>> searchPaginatedPosts({
    required int skip,
    required String query,
  });
}

class SaleRemoteDatasource extends SaleDatasource {
  final NetworkService networkService;
  SaleRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedPosts({
    required int skip,
    required bool isExpired,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters.addAll({
      'page': skip,
      'per_page': postPerPage,
      'status': isExpired ? 'Expired' : 'Active',
    });
    final response = await networkService.get(
      AppConfigs.mySaleEndpoint,
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
  Future<Either<AppException, PaginatedResponse>> searchPaginatedPosts({
    required int skip,
    required String query,
  }) async {
    final response = await networkService.get(
      AppConfigs.mySaleEndpoint,
      queryParameters: {'page': skip, 'per_page': postPerPage, 'q': query},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'search PaginatedData',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = PaginatedResponse.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }
}
