import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/authentication/domain/providers/login_provider.dart';
import 'package:findcarsale/features/authentication/domain/repositories/auth_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';

class ChangeNewPasswordFromForgotNotifierProvider
    extends StateNotifier<FormzState> {
  final AuthenticationRepository authRepository;

  ChangeNewPasswordFromForgotNotifierProvider({required this.authRepository})
    : super(const FormzState.initial());

  Future<void> changeNewPasswordFromForgotPassword(
    Map<String, dynamic> user,
  ) async {
    state = const FormzState.loading();
    final response = await authRepository.changeNewPasswordFromForgotPassword(
      user: user,
    );

    state = await response.fold((failure) => FormzState.failure(failure), (
      user,
    ) async {
      final data = user.data;
      return FormzState.success(data: data['message'] ?? data);
    });
  }
}

/// [used for forgot Password]
final changeNewPasswordfromForgotPasswordProvider = StateNotifierProvider<
  ChangeNewPasswordFromForgotNotifierProvider,
  FormzState
>((ref) {
  final AuthenticationRepository authenticationRepository = ref.read(
    authRepositoryProvider,
  );
  return ChangeNewPasswordFromForgotNotifierProvider(
    authRepository: authenticationRepository,
  );
});
