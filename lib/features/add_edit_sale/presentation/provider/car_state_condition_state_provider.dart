import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for car condition notifier
final carStateConditionNotifierProvider =
    StateNotifierProvider<CarStateConditionNotifier, bool?>((ref) {
      return CarStateConditionNotifier();
    });

class CarStateConditionNotifier extends StateNotifier<bool?> {
  CarStateConditionNotifier() : super(null);

  void updateCarCondition(bool? isNew) {
    state = isNew;
  }

  bool? getCarCondition() {
    return state;
  }
}
