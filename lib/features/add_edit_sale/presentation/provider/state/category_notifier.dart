import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/add_edit_sale/data/repositories/get_categories_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

class CategoryNotifier extends StateNotifier<FormzState> {
  final GetCategoryRepository catRepository;

  CategoryNotifier(this.catRepository) : super(const FormzState.initial());

  Future<void> fetchAllCatList() async {
    state = const FormzState.loading();

    final response = await catRepository.getCategoryList();
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

class AddCategoryNotifier extends StateNotifier<FormzState> {
  final GetCategoryRepository catRepository;

  AddCategoryNotifier(this.catRepository) : super(const FormzState.initial());

  Future<void> addCateggory(String catName) async {
    state = const FormzState.loading();

    final response = await catRepository.addCategory(catName);
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
