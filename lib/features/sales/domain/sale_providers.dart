import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/remote/network_service.dart';
import '../../../shared/domain/providers/dio_network_service_provider.dart';
import '../data/datasource/sale_remote_datasource.dart';
import '../data/repositories/sale_repository_imp.dart';

final saleDatasourceProvider = Provider.family<SaleDatasource, NetworkService>(
  (_, networkService) => SaleRemoteDatasource(networkService),
);

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  final networkService = ref.watch(netwokServiceProvider);
  final datasource = ref.read(saleDatasourceProvider(networkService));
  final respository = SaleRepositoryImpl(datasource);
  return respository;
});
