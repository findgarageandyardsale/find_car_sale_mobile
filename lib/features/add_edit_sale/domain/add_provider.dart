import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/data/remote/network_service.dart';

import '../../../shared/domain/providers/dio_network_service_provider.dart';
import '../data/datasource/add_garage_remote_datasource.dart';
import '../data/repositories/add_garage_repository.dart';

final addDatasourceProvider =
    Provider.family<AddGarageDatasource, NetworkService>(
      (_, networkService) => AddGarageRemoteDatasource(networkService),
    );
final addRepositoryProvider = Provider<AddGarageRepository>((ref) {
  final networkService = ref.watch(netwokServiceProvider);
  final datasource = ref.read(addDatasourceProvider(networkService));
  final respository = AddGarageRepositoryImpl(datasource);
  return respository;
});
