import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/domain/models/user/user_model.dart';
import 'user_cache_provider.dart';

final currentUserProvider = FutureProvider<User?>((ref) async {
  final repository = await ref
      .watch(userLocalRepositoryProvider.select((value) => value.fetchUser()));
  final eitherType = repository;

  return eitherType.fold((l) => null, (r) => r);
});

final deletecurrentUserProvider = FutureProvider((ref) async {
  final repository = ref.read(userLocalRepositoryProvider);
  await repository.deleteUser();
});
