import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/repository/feedback_repository.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import '../../../domain/providers/feedback_provider.dart';

/// [Used For chnage password provider]
final postFeedbackNotifierProvider =
    StateNotifierProvider<PostFeedbackNotifier, FormzState>((ref) {
      final FeedbackRepository accRepo = ref.watch(feedbackRepositoryProvider);

      return PostFeedbackNotifier(userAccountRepository: accRepo);
    });

class PostFeedbackNotifier extends StateNotifier<FormzState> {
  final FeedbackRepository userAccountRepository;

  PostFeedbackNotifier({required this.userAccountRepository})
    : super(const FormzState.initial());

  initState() {
    state = const FormzState.initial();
  }

  Future<void> postFeedback({required Map<String, dynamic> map}) async {
    state = const FormzState.loading();
    final response = await userAccountRepository.createFeedback(map: map);

    state = await response.fold((failure) => FormzState.failure(failure), (
      response,
    ) async {
      return const FormzState.success();
    });
  }
}
