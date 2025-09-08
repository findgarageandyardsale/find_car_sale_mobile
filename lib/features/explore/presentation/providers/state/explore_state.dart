// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../../shared/domain/models/garage_yard/garage_yard_model.dart';

enum ExploreConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllExplore
}

class ExploreState extends Equatable {
  final List<Garageayard> garageYardList;
  final int total;
  final int page;
  final bool hasData;
  final ExploreConcreteState state;
  final String message;
  final bool isLoading;
  const ExploreState({
    this.garageYardList = const [],
    this.isLoading = false,
    this.hasData = false,
    this.state = ExploreConcreteState.initial,
    this.message = '',
    this.page = 0,
    this.total = 0,
  });

  const ExploreState.initial({
    this.garageYardList = const [],
    this.total = 0,
    this.page = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = ExploreConcreteState.initial,
    this.message = '',
  });

  ExploreState copyWith({
    List<Garageayard>? garageYardList,
    int? total,
    int? page,
    bool? hasData,
    ExploreConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      garageYardList: garageYardList ?? this.garageYardList,
      total: total ?? this.total,
      page: page ?? this.page,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'ExploreState(isLoading:$isLoading, exploreLength: ${garageYardList.length},total:$total page: $page, hasData: $hasData, state: $state, message: $message)';
  }

  @override
  List<Object?> get props => [garageYardList, page, hasData, state, message];
}
