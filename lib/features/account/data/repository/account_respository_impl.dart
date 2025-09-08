import 'package:dartz/dartz.dart';
import 'package:findcarsale/features/account/data/datasource/account_remote_data_source.dart';
import 'package:findcarsale/features/account/domain/repository/account_repository.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';

class AccountRespositoryImpl extends AccountRepository {
  final AccountDatasource datasource;
  AccountRespositoryImpl(this.datasource);
  @override
  Future<Either<AppException, ResponseData>> changePassword({
    required Map<String, dynamic> map,
  }) {
    return datasource.changePassword(map: map);
  }

  @override
  Future<Either<AppException, ResponseData>> editProfile({
    required Map<String, dynamic> map,
    required String userId,
  }) {
    return datasource.editProfile(map: map, userId: userId);
  }

  @override
  Future<Either<AppException, ResponseData>> getProfile() {
    return datasource.getProfile();
  }

  @override
  Future<Either<AppException, ResponseData>> deleteProfile(String id) {
    return datasource.deleteProfile(id);
  }

  @override
  Future<Either<AppException, ResponseData>> logout({String? token}) async {
    return await datasource.logout(token: token);
  }
}
