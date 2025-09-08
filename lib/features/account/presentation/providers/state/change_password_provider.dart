import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/providers/account_provider.dart';
import 'package:findcarsale/features/account/domain/repository/account_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

/// [Used For chnage password provider]
final changePasswordNotifierProvider =
    StateNotifierProvider<ChangePasswordNotifier, FormzState>((ref) {
      final AccountRepository accRepo = ref.watch(accountRepositoryProvider);

      return ChangePasswordNotifier(userAccountRepository: accRepo);
    });

class ChangePasswordNotifier extends StateNotifier<FormzState> {
  final AccountRepository userAccountRepository;

  ChangePasswordNotifier({required this.userAccountRepository})
    : super(const FormzState.initial());

  initState() {
    state = const FormzState.initial();
  }

  Future<void> changePassword({required Map<String, dynamic> map}) async {
    state = const FormzState.loading();
    final response = await userAccountRepository.changePassword(map: map);

    state = await response.fold((failure) => FormzState.failure(failure), (
      response,
    ) async {
      return const FormzState.success();
    });
  }
}
