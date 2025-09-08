import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/data/repositories/add_garage_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

import '../../domain/add_provider.dart';
import 'add_data_provider.dart';
import 'state/add_notifier.dart';

final addNotifierProvider = StateNotifierProvider<AddNotifier, FormzState>((
  ref,
) {
  final AddGarageRepository addRepository = ref.read(addRepositoryProvider);
  final data = ref.watch(addDataNotifierProvider);
  return AddNotifier(addRepository: addRepository, postData: data);
});
