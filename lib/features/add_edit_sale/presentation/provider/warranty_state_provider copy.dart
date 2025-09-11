// Provider for car condition notifier
import 'package:flutter_riverpod/flutter_riverpod.dart';

final warrantyStateNotifierProvider =
    StateNotifierProvider<WarrantyStateNotifier, bool?>((ref) {
      return WarrantyStateNotifier();
    });

class WarrantyStateNotifier extends StateNotifier<bool?> {
  WarrantyStateNotifier() : super(null);

  void updateWarrantyCondition(bool? isNew) {
    state = isNew;
  }

  bool? getWarrantyCondition() {
    return state;
  }
}
