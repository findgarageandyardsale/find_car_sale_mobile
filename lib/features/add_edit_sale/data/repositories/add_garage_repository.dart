import 'package:dartz/dartz.dart';

import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../datasource/add_garage_remote_datasource.dart';

abstract class AddGarageRepository {
  Future<Either<AppException, ResponseData>> addGaragePost(
      {required Map<String, dynamic> singleItem});
  Future<Either<AppException, ResponseData>> editGaragePost(
      {required Map<String, dynamic> singleItem, required int id});
  Future<Either<AppException, ResponseData>> payementForGaragePost(
      {required Map<String, dynamic> singleItem, required int id});
}

class AddGarageRepositoryImpl extends AddGarageRepository {
  final AddGarageDatasource addGarageDatasource;
  AddGarageRepositoryImpl(this.addGarageDatasource);

  @override
  Future<Either<AppException, ResponseData>> addGaragePost(
      {required Map<String, dynamic> singleItem}) {
    return addGarageDatasource.addPost(singleItem: singleItem);
  }

  @override
  Future<Either<AppException, ResponseData>> editGaragePost(
      {required Map<String, dynamic> singleItem, required int id}) {
    return addGarageDatasource.editPost(singleItem: singleItem, id: id);
  }

  @override
  Future<Either<AppException, ResponseData>> payementForGaragePost(
      {required Map<String, dynamic> singleItem, required int id}) {
    return addGarageDatasource.payementForGaragePost(
        singleItem: singleItem, id: id);
  }
}
