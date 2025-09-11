import 'package:dartz/dartz.dart';
import 'package:findcarsale/configs/app_configs.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';
import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/models/paginated_response.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AddGarageDatasource {
  Future<Either<AppException, ResponseData>> addPost({
    required Map<String, dynamic> singleItem,
  });
  Future<Either<AppException, ResponseData>> editPost({
    required Map<String, dynamic> singleItem,
    required int id,
  });
  Future<Either<AppException, ResponseData>> payementForGaragePost({
    required Map<String, dynamic> singleItem,
    required int id,
  });
  Future<Either<AppException, PaginatedResponse>> getCarCondition();
  Future<Either<AppException, ResponseData>> postCarcondition(String catName);
}

class AddGarageRemoteDatasource extends AddGarageDatasource {
  final NetworkService networkService;
  AddGarageRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, ResponseData>> addPost({
    required Map<String, dynamic> singleItem,
  }) async {
    final response = await networkService.post(
      AppConfigs.createSales,
      data: singleItem,
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'addGarageSale',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = ResponseData.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, ResponseData>> editPost({
    required Map<String, dynamic> singleItem,
    required int id,
  }) async {
    final response = await networkService.put(
      '${AppConfigs.createSales}$id/',
      data: singleItem,
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'editGarageSale',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = ResponseData.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, ResponseData>> payementForGaragePost({
    required Map<String, dynamic> singleItem,
    required int id,
  }) async {
    final response = await networkService.put(
      '${AppConfigs.payementSales}$id/',
      data: singleItem,
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'payementForGaragePost',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = ResponseData.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, PaginatedResponse>> getCarCondition() async {
    final response = await networkService.get(
      AppConfigs.getCarCondition,
      queryParameters: {'per_page': 100},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'fetchCategoryData',
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
  Future<Either<AppException, ResponseData>> postCarcondition(
    String catName,
  ) async {
    final response = await networkService.post(
      AppConfigs.getCarCondition,
      data: {'name': catName},
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'post Cat data',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = ResponseData.fromJson(jsonData);
      return Right(paginatedResponse);
    });
  }
}
