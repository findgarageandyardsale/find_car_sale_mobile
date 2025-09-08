import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/data/datasource/account_remote_data_source.dart';
import 'package:findcarsale/shared/data/remote/network_service.dart';
import 'package:findcarsale/shared/domain/providers/dio_network_service_provider.dart';

import '../../data/repository/account_respository_impl.dart';
import '../repository/account_repository.dart';

final accountdataSourceProvider =
    Provider.family<AccountDatasource, NetworkService>(
      (_, networkService) => AccountRemoteDataSource(networkService),
    );

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final NetworkService networkService = ref.watch(netwokServiceProvider);

  final AccountDatasource dataSource = ref.read(
    accountdataSourceProvider(networkService),
  );

  return AccountRespositoryImpl(dataSource);
});
