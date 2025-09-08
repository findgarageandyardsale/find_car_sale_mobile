import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../../shared/domain/models/paginated_response.dart';
import '../../../../../shared/exceptions/http_exception.dart';
import '../../../explore/presentation/providers/state/explore_state.dart';
import '../../data/repositories/sale_repository_imp.dart';

class SaleNotifier extends StateNotifier<ExploreState> {
  final SaleRepository saleRepository;
  bool isExpired;

  SaleNotifier(this.saleRepository, this.isExpired)
      : super(const ExploreState.initial());

  bool get isFetching =>
      state.state != ExploreConcreteState.loading &&
      state.state != ExploreConcreteState.fetchingMore;

  Future<void> fetchExplorePosts() async {
    if (isFetching && state.state != ExploreConcreteState.fetchedAllExplore) {
      state = state.copyWith(
        state: state.page > 0
            ? ExploreConcreteState.fetchingMore
            : ExploreConcreteState.loading,
        isLoading: true,
      );

      final response = await saleRepository.fetchExplorePost(
        page: state.page + 1,
        isExpired: isExpired,
      );

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: ExploreConcreteState.fetchedAllExplore,
        message: 'No more products available',
        isLoading: false,
      );
    }
  }

  Future<void> searchExplorePosts(String query) async {
    if (isFetching && state.state != ExploreConcreteState.fetchedAllExplore) {
      state = state.copyWith(
        state: state.page > 0
            ? ExploreConcreteState.fetchingMore
            : ExploreConcreteState.loading,
        isLoading: true,
      );

      final response = await saleRepository.searchExplorePost(
        page: state.page + 1,
        query: query,
      );

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: ExploreConcreteState.fetchedAllExplore,
        message: 'No more products available',
        isLoading: false,
      );
    }
  }

  void updateStateFromResponse(
      Either<AppException, PaginatedResponse> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: ExploreConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      //

      final garageYardList =
          (data.data ?? []).map((e) => Garageayard.fromJson(e)).toList();

      final totalList = [...state.garageYardList, ...garageYardList];

      state = state.copyWith(
        garageYardList: totalList,
        state: totalList.length == data.pagination?.total
            ? ExploreConcreteState.fetchedAllExplore
            : ExploreConcreteState.loaded,
        hasData: true,
        message: totalList.isEmpty ? 'No posts found' : data.message,
        page: (data.pagination?.currentPage ?? 0),
        total: data.pagination?.total,
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const ExploreState.initial();
  }
}
