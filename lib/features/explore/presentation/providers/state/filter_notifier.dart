import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:state_notifier/state_notifier.dart';
import 'filter_state.dart';

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState.initial());

  void updateState({
    String? zipCode,
    double? radius,
    DateTime? startDate,
    DateTime? endDate,
    bool? isGarage,
    List<Category>? selectedCategories,
  }) {
    state = state.copyWith(
      zipCode: zipCode ?? state.zipCode,
      radius: radius ?? state.radius,
      startDate: startDate ?? state.startDate,
      endDate: endDate ?? state.endDate,
      selectedCategories: selectedCategories ?? state.selectedCategories,
    );
  }

  void updateGarage({bool? isGarage}) {
    state = state.copyWith(isGarage: isGarage);
  }

  void updateToInitial() {
    final stateVal = FilterState.initial();
    state = stateVal;
  }

  void toDateInitalState() {
    state = state.copyWithDate(sDate: DateTime.now(), eDate: null);
  }

  void toRadiusInitalState() {
    state = state.copyWithRadius(rad: null);
  }

  void updateRadius(double radius) {
    state = state.copyWith(radius: radius);
  }

  void updateZipCode(String zipCode) {
    state = state.copyWith(zipCode: zipCode);
  }

  void updateStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void updateEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void updateIsGarage(bool isGarage) {
    state = state.copyWith(isGarage: isGarage);
  }

  bool isSelectedCategory(Category category) {
    return (state.selectedCategories ?? []).any(
      (element) => element.id == category.id,
    );
  }

  void updateCat(Category cat) {
    try {
      // Create a new list of categories to ensure state change
      List<Category> categories = List.from(state.selectedCategories ?? []);

      if (categories.contains(cat)) {
        // Remove the category if it's already selected
        categories.removeWhere((element) => element.id == cat.id);
      } else {
        // Add the category if it's not selected
        categories.add(cat);
      }

      // Update the state with a new instance of Garageayard
      state = state.copyWith(selectedCategories: categories);
    } catch (e) {
      // log('UpdateCat Error: ${e.toString()}');
    }
  }
}
