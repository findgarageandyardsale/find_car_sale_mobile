import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/data/repositories/get_categories_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

class CarConditionNotifier extends StateNotifier<FormzState> {
  final GetCarConditionRepository catRepository;

  CarConditionNotifier(this.catRepository) : super(const FormzState.initial());

  Future<void> fetchAllCatList() async {
    state = const FormzState.loading();

    final response = await catRepository.getCarConditionList();
    //  Check if the notifier is still mounted before updating the state
    if (mounted) {
      state = response.fold(
        (l) => FormzState.failure(l),
        (r) => FormzState.success(data: r.data),
      );
    }
  }

  void resetState() {
    state = const FormzState.initial();
  }
}

class AddCarConditionNotifier extends StateNotifier<FormzState> {
  final GetCarConditionRepository catRepository;

  AddCarConditionNotifier(this.catRepository)
    : super(const FormzState.initial());

  Future<void> addCateggory(String catName) async {
    state = const FormzState.loading();

    final response = await catRepository.addCarCondition(catName);
    //  Check if the notifier is still mounted before updating the state
    if (mounted) {
      state = response.fold((l) => FormzState.failure(l), (r) {
        return FormzState.success(data: r.data);
      });
    }
  }

  void resetState() {
    state = const FormzState.initial();
  }
}
