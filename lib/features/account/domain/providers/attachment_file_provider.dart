import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/data/datasource/attachment_file_data_source.dart';
import 'package:findcarsale/features/account/data/repository/attachment_file_respository_impl.dart';
import 'package:findcarsale/features/account/domain/repository/attachment_file_repository.dart';
import 'package:findcarsale/shared/data/remote/network_service.dart';
import 'package:findcarsale/shared/domain/providers/dio_network_service_provider.dart';

final attachmentFileDataSourceProvider =
    Provider.family<AttachmentFileDataSource, NetworkService>(
      (_, networkService) => AttachmentFileRemoteDataSource(networkService),
    );

final attachmentFileRepositoryProvider = Provider<AttachmentFileRepository>((
  ref,
) {
  final NetworkService networkService = ref.watch(netwokServiceProvider);

  final AttachmentFileDataSource dataSource = ref.read(
    attachmentFileDataSourceProvider(networkService),
  );

  return AttachmentFileRespositoryImpl(dataSource);
});
