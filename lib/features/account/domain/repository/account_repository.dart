import 'package:dartz/dartz.dart';

import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';

abstract class AccountRepository {
  Future<Either<AppException, ResponseData>> changePassword(
      {required Map<String, dynamic> map});
  Future<Either<AppException, ResponseData>> editProfile(
      {required Map<String, dynamic> map, required String userId});
  Future<Either<AppException, ResponseData>> getProfile();
  Future<Either<AppException, ResponseData>> deleteProfile(String id);
  Future<Either<AppException, ResponseData>> logout({String? token});
}
