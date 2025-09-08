import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/sales/domain/sale_providers.dart';
import 'package:findcarsale/features/sales/presentation/provider/sale_notifier.dart';

import '../../../explore/presentation/providers/state/explore_state.dart';

final saleNotifierProvider =
    StateNotifierProvider.autoDispose<SaleNotifier, ExploreState>((ref) {
      final repository = ref.read(saleRepositoryProvider);
      final isExpired = ref.watch(isExpiredSalesProvider);

      return SaleNotifier(repository, isExpired)
        ..resetState()
        ..fetchExplorePosts();
    });

final isExpiredSalesProvider = StateProvider.autoDispose<bool>((ref) => false);
