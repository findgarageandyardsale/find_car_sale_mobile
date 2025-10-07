import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/domain/providers/explore_providers.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

// Provider to fetch garage yard details by ID
final garageYardProvider = FutureProvider.family<Garageayard?, String>((
  ref,
  garageYardId,
) async {
  try {
    final repository = ref.read(exploreRepositoryProvider);
    final result = await repository.fetchDetailPost(
      id: int.tryParse(garageYardId),
    );

    return result.fold((failure) => null, (garageYard) => garageYard);
  } catch (e) {
    return null;
  }
});
