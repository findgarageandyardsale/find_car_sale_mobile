import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/provider/state/category_notifier.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

import '../../domain/category_providers.dart';

final carconditionNotifierProvider =
    StateNotifierProvider.autoDispose<CarConditionNotifier, FormzState>((ref) {
      final repository = ref.read(categoryRepositoryProvider);
      return CarConditionNotifier(repository)..fetchAllCatList();
    });
final addCarConditionNotifierProvider =
    StateNotifierProvider.autoDispose<AddCarConditionNotifier, FormzState>((
      ref,
    ) {
      final repository = ref.read(categoryRepositoryProvider);
      return AddCarConditionNotifier(repository);
    });
