import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../shared/data/local/storage_service.dart';
import '../../../../shared/domain/models/user/user_model.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../../../../shared/globals.dart';

abstract class UserDataSource {
  String get storageKey;

  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class UserLocalDatasource extends UserDataSource {
  UserLocalDatasource(this.stroageService);

  final StroageService stroageService;

  @override
  String get storageKey => userLocalStorageKey;

  @override
  Future<Either<AppException, User>> fetchUser() async {
    final data = await stroageService.get(storageKey);
    if (data == null) {
      return Left(
        AppException(
          identifier: 'UserLocalDatasource',
          statusCode: 404,
          message: 'User not found',
        ),
      );
    }
    final userJson = jsonDecode(data.toString());

    return Right(User.fromJson(userJson));
  }

  @override
  Future<bool> saveUser({required User user}) async {
    final saveStatus =  await stroageService.set(storageKey, jsonEncode(user.toJson()));
    return saveStatus;
  }

  @override
  Future<bool> deleteUser() async {
    return await stroageService.remove(storageKey);
  }

  @override
  Future<bool> hasUser() async {
    return await stroageService.has(storageKey);
  }
}
