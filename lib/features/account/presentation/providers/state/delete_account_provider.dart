import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/providers/account_provider.dart';
import 'package:findcarsale/features/account/domain/repository/account_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

/// [Used For chnage password provider]
final deleteAccountNotifierProvider =
    StateNotifierProvider<DeleteAccountNotifier, FormzState>((ref) {
      final AccountRepository accRepo = ref.watch(accountRepositoryProvider);

      return DeleteAccountNotifier(userAccountRepository: accRepo);
    });

class DeleteAccountNotifier extends StateNotifier<FormzState> {
  final AccountRepository userAccountRepository;

  DeleteAccountNotifier({required this.userAccountRepository})
    : super(const FormzState.initial());

  initState() {
    state = const FormzState.initial();
  }

  Future<void> deleteAccount({required String id}) async {
    state = const FormzState.loading();
    final response = await userAccountRepository.deleteProfile(id);

    state = await response.fold((failure) => FormzState.failure(failure), (
      response,
    ) async {
      return const FormzState.success();
    });
  }
}
