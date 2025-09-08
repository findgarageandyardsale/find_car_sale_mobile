import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/domain/repositories/explore_repository.dart';
import 'package:findcarsale/features/explore/presentation/providers/state/filter_state.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import '../../../../../services/location_service/presentation/state/location_state.dart';
import '../../../../../shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../../shared/domain/models/paginated_response.dart';
import '../../../../../shared/exceptions/http_exception.dart';
import 'explore_state.dart';

class ExploreNotifier extends StateNotifier<ExploreState> {
  final ExploreRepository exploreRepository;
  final LocationState locationState;
  final FilterState filterState;

  ExploreNotifier(this.exploreRepository, this.filterState, this.locationState)
    : super(const ExploreState.initial());

  bool get isFetching =>
      state.state != ExploreConcreteState.loading &&
      state.state != ExploreConcreteState.fetchingMore;

  Future<void> fetchExplorePosts({String? search}) async {
    if (isFetching && state.state != ExploreConcreteState.fetchedAllExplore) {
      if (state.state != ExploreConcreteState.loading &&
          state.isLoading != true) {
        state = state.copyWith(
          state:
              state.page > 0
                  ? ExploreConcreteState.fetchingMore
                  : ExploreConcreteState.loading,
          isLoading: true,
        );

        Map<String, dynamic> mapData = {
          ...filterState.toJson(),
          if (locationState.currentLatLng != null)
            'user_lat': locationState.currentLatLng!.latitude,
          if (locationState.currentLatLng != null)
            'user_lon': locationState.currentLatLng!.longitude,
          'q': (search ?? '').isNotEmpty ? search : null,
        };
        if (filterState.isGarage != null) {
          mapData.addAll({
            'type': filterState.isGarage == true ? 'Garage' : 'Yard',
          });
        }
        final response = await exploreRepository.fetchExplorePost(
          page: state.page + 1,
          filter: mapData,
        );

        updateStateFromResponse(response);
      }
    }
  }

  void resetFetchingStateToPage0() {
    state = state.copyWith(
      page: 0,
      state: ExploreConcreteState.initial,
      garageYardList: null,
    );
  }

  void updateStateFromResponse(
    Either<AppException, PaginatedResponse> response,
  ) {
    if (mounted) {
      response.fold(
        (failure) {
          state = state.copyWith(
            state: ExploreConcreteState.failure,
            message: failure.message,
            isLoading: false,
          );
        },
        (data) {
          //
          if (data.pagination?.currentPage == 1) {
            state = state.copyWith(garageYardList: []);
          }

          final garageYardList =
              (data.data ?? []).map((e) => Garageayard.fromJson(e)).toList();

          final totalList = [...state.garageYardList, ...garageYardList];

          if (mounted) {
            state = state.copyWith(
              garageYardList: totalList,
              state:
                  totalList.length == data.pagination?.total
                      ? ExploreConcreteState.fetchedAllExplore
                      : ExploreConcreteState.loaded,
              hasData: true,
              message: totalList.isEmpty ? 'No posts found' : data.message,
              page: (data.pagination?.currentPage ?? 0),
              total: data.pagination?.total,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  /*

  if (mounted) {
        state = state.copyWith(
          state: ExploreConcreteState.fetchedAllExplore,
          message: 'No more products available',
          isLoading: false,
        );
      }
  */

  void resetState() {
    if (mounted) state = const ExploreState.initial();
  }
}

class DetailPageNotifier extends StateNotifier<FormzState> {
  final ExploreRepository repository;

  DetailPageNotifier(this.repository) : super(const FormzState.loading());

  void fetchPostDetails(int? postId) async {
    try {
      state = const FormzState.loading();
      final postDetails = await repository.fetchDetailPost(id: postId);

      state = postDetails.fold(
        (failure) => FormzState.failure(
          AppException(message: failure.message, statusCode: 0, identifier: ''),
        ),
        (data) {
          return FormzState.success(data: data);
        },
      );
    } catch (e) {
      state = FormzState.failure(
        AppException(message: e.toString(), statusCode: 0, identifier: ''),
      );
    }
  }
}
