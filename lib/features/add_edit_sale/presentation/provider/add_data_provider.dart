import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

import 'state/add_data_notifier.dart';

final addDataNotifierProvider =
    StateNotifierProvider<AddDataNotifier, Garageayard?>((ref) {
      return AddDataNotifier()..addInitialTimeSlot();
    });

final loadingFilesProvider = StateProvider.autoDispose.family<bool, String>((
  ref,
  key,
) {
  return false; // Initial value for each unique key
});
