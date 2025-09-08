import 'package:auto_route/auto_route.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/auth_field.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';

import '../../../../shared/presentation/formz_state.dart';
import '../providers/state/post_feedback_provider.dart';

@RoutePage()
class FeedbackScreen extends ConsumerWidget {
  FeedbackScreen({super.key});

  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postFeedbackNotifierProvider);
    final ratingNumber = ref.watch(ratingState);
    ref.listen(postFeedbackNotifierProvider.select((value) => value), ((
      previous,
      next,
    ) {
      next.maybeWhen(
        orElse: () {},
        failure: (failure) {
          CustomToast.showToast(
            failure.message.toString(),
            status: ToastStatus.error,
          );
        },
        success: (success) {
          CustomToast.showToast(
            'Feedback added successfully',
            status: ToastStatus.success,
          );
          Navigator.pop(context);
        },
      );
    }));
    return CustomLoadingOverlay(
      isLoading: state is Loading,
      child: Scaffold(
        appBar: AppBar(title: const Text('Feedback')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Give us a rating',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.sizedBoxH_08(),
                  RatingBar(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    onRatingChanged: (value) {
                      ref.read(ratingState.notifier).state = value;
                    },
                    initialRating: ratingNumber,
                    maxRating: 5,
                  ),
                  Spacing.sizedBoxH_16(),
                  Text(
                    'Feedback',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacing.sizedBoxH_08(),
                  AuthField(
                    name: 'comment',
                    hintText: 'Comment',
                    controller: commentController,
                    maxlines: 4,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Comment is empty.',
                      ),
                    ]),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                  ),
                  Spacing.sizedBoxH_20(),
                  ActionButton(
                    width: double.infinity,
                    label: 'Submit Feedback',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.saveAndValidate()) {
                        ref
                            .read(postFeedbackNotifierProvider.notifier)
                            .postFeedback(
                              map: {
                                'number': ref.read(ratingState).toInt(),
                                'comment': commentController.text,
                              },
                            );
                      }
                    },
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final ratingState = StateProvider<double>((ref) => 3.0);
