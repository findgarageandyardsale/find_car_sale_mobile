import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/paginated_response.dart';
import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../datasource/add_garage_remote_datasource.dart';

abstract class GetCarConditionRepository {
  Future<Either<AppException, PaginatedResponse>> getCarConditionList();
  Future<Either<AppException, ResponseData>> addCarCondition(String catName);
}

class GetCategoryRepositoryImpl extends GetCarConditionRepository {
  final AddGarageDatasource addGarageDatasource;
  GetCategoryRepositoryImpl(this.addGarageDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> getCarConditionList() {
    return addGarageDatasource.getCarCondition();
  }

  @override
  Future<Either<AppException, ResponseData>> addCarCondition(String catName) {
    return addGarageDatasource.postCarcondition(catName);
  }
}
