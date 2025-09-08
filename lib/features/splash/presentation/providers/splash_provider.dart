import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/user_cache_service/domain/providers/user_cache_provider.dart';

final userLoginCheckProvider = FutureProvider((ref) async {
  final repo = ref.read(userLocalRepositoryProvider);
  return await repo.hasUser();
});
