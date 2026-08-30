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
  Future<Either<AppException, String>> markAsSold({required int id});
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

  @override
  Future<Either<AppException, String>> markAsSold({required int id}) async {
    final response = await networkService.post(
      '${AppConfigs.yardSaleEndpoint}update_status/',
      data: {
        'status': 'Sold',
        'carsale_ids': [id],
      },
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'markAsSold',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }

      // Handle the API response structure: {"status":200,"message":"Success","data":{}}
      if (jsonData is Map<String, dynamic>) {
        final status = jsonData['status'];
        final message = jsonData['message'];

        // Check if the API call was successful
        if (status == 200 && message == 'Success') {
          return Right('Post marked as sold successfully');
        } else {
          return Left(
            AppException(
              identifier: 'markAsSold',
              statusCode: status ?? 0,
              message: message ?? 'Failed to mark as sold',
            ),
          );
        }
      }

      return Right('Post marked as sold successfully');
    });
  }
}
