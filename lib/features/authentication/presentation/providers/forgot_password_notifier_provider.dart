import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/authentication/domain/providers/login_provider.dart';
import 'package:findcarsale/features/authentication/domain/repositories/auth_repository.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class ForgotPasswordNotifierProvider extends StateNotifier<FormzState> {
  final AuthenticationRepository authRepository;

  ForgotPasswordNotifierProvider({required this.authRepository})
    : super(const FormzState.initial());

  Future<void> forgotPassword(Map<String, dynamic> user) async {
    try {
      state = const FormzState.loading();
      final response = await authRepository.forgotPassword(user: user);

      state = await response.fold((failure) => FormzState.failure(failure), (
        user,
      ) async {
        final data = user.data;
        PrintUtils.customLog(data.toString());
        return FormzState.success(data: data['message'] ?? data);
      });
    } catch (e) {
      state = FormzState.failure(
        AppException(
          message: e.toString(),
          statusCode: 500,
          identifier: 'Issue',
        ),
      );
    }
  }
}

/// [used for forgot Password]
final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifierProvider, FormzState>((ref) {
      final AuthenticationRepository authenticationRepository = ref.read(
        authRepositoryProvider,
      );
      return ForgotPasswordNotifierProvider(
        authRepository: authenticationRepository,
      );
    });
