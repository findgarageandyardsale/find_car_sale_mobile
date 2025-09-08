import 'package:dartz/dartz.dart';
import 'package:findcarsale/configs/app_configs.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';
import '../../../../shared/data/remote/network_service.dart';
import '../../../../shared/domain/models/models.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
  Future<Either<AppException, ResponseData>> signupUser({
    required Map<String, dynamic> user,
  });

  Future<Either<AppException, ResponseData>> forgotPassword({
    required Map<String, dynamic> user,
  });

  Future<Either<AppException, ResponseData>>
  changeNewPasswordFromForgotPassword({required Map<String, dynamic> user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;

  LoginUserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        AppConfigs.loginEndpoint,
        data: user.toJson(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final responseData = ResponseData.fromJson(response.data);
          final user = User.fromJson(responseData.data);
          // update the token for requests
          networkService.updateHeader({'Authorization': 'Token ${user.token}'});
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> signupUser({
    required Map<String, dynamic> user,
  }) async {
    try {
      final eitherType = await networkService.post(
        AppConfigs.signupEndpoint,
        data: user,
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
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>> forgotPassword({
    required Map<String, dynamic> user,
  }) async {
    try {
      final eitherType = await networkService.post(
        AppConfigs.requestEmailforgotPassword,
        data: user,
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
          identifier:
              '${e.toString()}\nLoginUserRemoteDataSource.forgotPassword',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ResponseData>>
  changeNewPasswordFromForgotPassword({
    required Map<String, dynamic> user,
  }) async {
    try {
      final eitherType = await networkService.post(
        AppConfigs.changeforgotPassword,
        data: user,
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
          identifier:
              '${e.toString()}\nLoginUserRemoteDataSource.changeNewPasswordFromForgotPassword',
        ),
      );
    }
  }
}
