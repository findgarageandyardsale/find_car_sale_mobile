import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/providers/account_provider.dart';
import 'package:findcarsale/features/account/domain/repository/account_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

/// [Used For edit profile provider]
final editProfileNotifierProvider =
    StateNotifierProvider<EditProfileNotifier, FormzState>((ref) {
      final AccountRepository accRepo = ref.read(accountRepositoryProvider);

      return EditProfileNotifier(userAccountRepository: accRepo);
    });

class EditProfileNotifier extends StateNotifier<FormzState> {
  final AccountRepository userAccountRepository;

  EditProfileNotifier({required this.userAccountRepository})
    : super(const FormzState.initial());
  initState() {
    state = const FormzState.initial();
  }

  Future<void> editProfile({
    required Map<String, dynamic> map,
    required String userId,
  }) async {
    state = const FormzState.loading();
    final response = await userAccountRepository.editProfile(
      map: map,
      userId: userId,
    );

    state = await response.fold((failure) => FormzState.failure(failure), (
      response,
    ) async {
      return const FormzState.success();
    });
  }
}
