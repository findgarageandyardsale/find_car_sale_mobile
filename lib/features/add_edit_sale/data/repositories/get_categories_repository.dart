import 'package:dartz/dartz.dart';
import 'package:findcarsale/shared/domain/models/paginated_response.dart';
import '../../../../shared/domain/models/response_data.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../datasource/add_garage_remote_datasource.dart';

abstract class GetCategoryRepository {
  Future<Either<AppException, PaginatedResponse>> getCategoryList();
  Future<Either<AppException, ResponseData>> addCategory(String catName);
}

class GetCategoryRepositoryImpl extends GetCategoryRepository {
  final AddGarageDatasource addGarageDatasource;
  GetCategoryRepositoryImpl(this.addGarageDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> getCategoryList() {
    return addGarageDatasource.getCategory();
  }

  @override
  Future<Either<AppException, ResponseData>> addCategory(String catName) {
    return addGarageDatasource.postCategory(catName);
  }
}
