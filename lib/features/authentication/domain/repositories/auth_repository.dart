import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';

import '../../../../shared/domain/models/models.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AuthenticationRepository {
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
