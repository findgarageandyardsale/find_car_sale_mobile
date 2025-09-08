import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';

import '../../../../shared/domain/models/user/user_model.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }

  @override
  Future<Either<AppException, ResponseData>> signupUser({
    required Map<String, dynamic> user,
  }) {
    return dataSource.signupUser(user: user);
  }

  @override
  Future<Either<AppException, ResponseData>> forgotPassword({
    required Map<String, dynamic> user,
  }) {
    return dataSource.forgotPassword(user: user);
  }

  @override
  Future<Either<AppException, ResponseData>>
  changeNewPasswordFromForgotPassword({required Map<String, dynamic> user}) {
    return dataSource.changeNewPasswordFromForgotPassword(user: user);
  }
}
