import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/providers/account_provider.dart';
import 'package:findcarsale/features/account/domain/repository/account_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

/// [Used For logout provider]
final logoutNotifierProvider =
    StateNotifierProvider<LogoutNotifier, FormzState>((ref) {
      final AccountRepository accRepo = ref.watch(accountRepositoryProvider);
      return LogoutNotifier(userAccountRepository: accRepo);
    });

class LogoutNotifier extends StateNotifier<FormzState> {
  final AccountRepository userAccountRepository;

  LogoutNotifier({required this.userAccountRepository})
    : super(const FormzState.initial());

  initState() {
    state = const FormzState.initial();
  }

  Future<void> logout({String? token}) async {
    state = const FormzState.loading();
    final response = await userAccountRepository.logout(token: token);

    state = await response.fold((failure) => FormzState.failure(failure), (
      response,
    ) async {
      return const FormzState.success();
    });
  }
}
