import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/authentication/presentation/providers/state/signup_notifier.dart';

import '../../../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../domain/providers/login_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import 'state/auth_notifier.dart';
import 'state/auth_state.dart';

/// [Used For Login provider]
final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
      final AuthenticationRepository authenticationRepository = ref.read(
        authRepositoryProvider,
      );
      final UserRepository userRepository = ref.read(
        userLocalRepositoryProvider,
      );
      return AuthNotifier(
        authRepository: authenticationRepository,
        userRepository: userRepository,
      );
    });

/// [Used for Signup State]
// final userNotifierProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
//   return UserNotifier();
// });

final checktermsProvider = StateProvider<bool>((ref) {
  return false;
});

/// [used for sign up]
final signupStateNotifierProvider =
    StateNotifierProvider<SignupNotifier, AuthState>((ref) {
      final AuthenticationRepository authenticationRepository = ref.read(
        authRepositoryProvider,
      );
      return SignupNotifier(authRepository: authenticationRepository);
    });
