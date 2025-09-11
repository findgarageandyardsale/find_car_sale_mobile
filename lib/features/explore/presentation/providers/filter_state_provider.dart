import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/state/filter_notifier.dart';
import 'package:findcarsale/features/explore/presentation/providers/state/filter_state.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

final filterNotifierProvider =
    StateNotifierProvider<FilterNotifier, FilterState>((ref) {
      return FilterNotifier();
    });

final sliderRangeProvider = StateProvider<double>((ref) {
  return 15.0;
});

final catListProvider = StateProvider.autoDispose<List<CarCondition>?>((ref) {
  return null;
});
