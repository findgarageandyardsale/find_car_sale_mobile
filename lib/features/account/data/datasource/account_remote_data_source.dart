import 'package:dartz/dartz.dart';
import 'package:findcarsale/configs/app_configs.dart';
import 'package:findcarsale/shared/data/remote/network_service.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';

import '../../../../shared/exceptions/http_exception.dart';

abstract class AccountDatasource {
  Future<Either<AppException, ResponseData>> changePassword({
    required Map<String, dynamic> map,
  });
  Future<Either<AppException, ResponseData>> editProfile({
    required Map<String, dynamic> map,
    required String userId,
  });
  Future<Either<AppException, ResponseData>> getProfile();
  Future<Either<AppException, ResponseData>> deleteProfile(String id);
  Future<Either<AppException, ResponseData>> logout({String? token});
}

class AccountRemoteDataSource implements AccountDatasource {
  final NetworkService networkService;
  AccountRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ResponseData>> changePassword({
    required Map<String, dynamic> map,
  }) async {
    try {
      final url = AppConfigs.changePasswordEndpoint;
      final eitherType = await networkService.post(url, data: map);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          return Right(response);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}\nAccountRemoteDataSource.changePassword',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> editProfile({
    required Map<String, dynamic> map,
    required String userId,
  }) async {
    try {
      final eitherType = await networkService.put(
        AppConfigs.getUserEndpoint(id: userId),
        data: map,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          return Right(response);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}\nAccountRemoteDataSource.editProfile',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> getProfile() async {
    try {
      final eitherType = await networkService.get(AppConfigs.profileEndpoint);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final responseData = ResponseData.fromJson(response.data);
          return Right(responseData);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nAccountRemoteDataSource.getProfile',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> deleteProfile(String id) async {
    try {
      final eitherType = await networkService.delete(
        '${AppConfigs.profileEndpoint}/$id',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final responseData = ResponseData.fromJson(response.data);
          return Right(responseData);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nAccountRemoteDataSource.deleteProfile',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> logout({String? token}) async {
    try {
      final eitherType = await networkService.post(
        AppConfigs.logout,
        data: {'token': token},
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final responseData = ResponseData.fromJson(response.data);
          return Right(responseData);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nAccountRemoteDataSource.logout',
        ),
      );
    }
  }
}
