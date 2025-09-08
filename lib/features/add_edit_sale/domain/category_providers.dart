import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/data/datasource/add_garage_remote_datasource.dart';

import '../../../shared/data/remote/network_service.dart';
import '../../../shared/domain/providers/dio_network_service_provider.dart';
import '../data/repositories/get_categories_repository.dart';

final categoryDatasourceProvider =
    Provider.family<AddGarageDatasource, NetworkService>(
      (_, networkService) => AddGarageRemoteDatasource(networkService),
    );

final categoryRepositoryProvider = Provider<GetCategoryRepository>((ref) {
  final networkService = ref.watch(netwokServiceProvider);
  final datasource = ref.read(categoryDatasourceProvider(networkService));
  final respository = GetCategoryRepositoryImpl(datasource);
  return respository;
});
