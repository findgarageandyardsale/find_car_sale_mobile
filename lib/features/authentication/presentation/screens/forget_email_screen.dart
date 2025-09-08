import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/providers/forgot_password_notifier_provider.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/app_image.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import '../../../../shared/widgets/action_button.dart';
import '../widgets/auth_field.dart';

@RoutePage()
class ForgetEmailScreen extends ConsumerWidget {
  ForgetEmailScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    // final state = ref.watch(authStateNotifierProvider);
    ref.listen(forgotPasswordProvider, ((previous, next) {
      next.maybeWhen(
        orElse: () {},
        failure: (failure) {
          CustomToast.showToast(
            failure.message.toString(),
            status: ToastStatus.error,
          );
        },
        success: (data) {
          if ((data ?? '').toString().isNotEmpty) {
            CustomToast.showToast(data.toString());
          }
          AutoRouter.of(
            context,
          ).push(CreateNewPasswordScreen(email: emailController.text));
        },
      );
    }));
    return CustomLoadingOverlay(
      isLoading: state is Loading,
      child: Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: AutofillGroup(
                  child: FormBuilder(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const AppImage(),
                        Spacing.sizedBoxH_36(),
                        Text(
                          'Forget Password?',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacing.sizedBoxH_16(),
                        Text(
                          'Please enter your email address to receive a verification code.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        Spacing.sizedBoxH_20(),
                        AuthField(
                          name: 'email',
                          hintText: 'Email',
                          labelText: 'Email',
                          controller: emailController,
                          autofillHints: const [
                            AutofillHints.email,
                            AutofillHints.username,
                          ],
                          textInputAction: TextInputAction.next,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Email Address is empty.',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'Invalid Email Address',
                            ),
                          ]),
                        ),
                        Spacing.sizedBoxH_16(),
                        ActionButton(
                          width: double.infinity,
                          label: 'Send Verification Code',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.saveAndValidate()) {
                              ref
                                  .read(forgotPasswordProvider.notifier)
                                  .forgotPassword({
                                    'email': emailController.text,
                                  });
                            }
                            // context.router.push(CreateNewPasswordScreen());
                          },
                          textColor: AppColors.white,
                        ),
                        Spacing.sizedBoxH_30(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Have a Pin?  ',
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(
                                        context,
                                      ).push(CreateNewPasswordScreen());
                                    },
                                    child: Text(
                                      'Change New Password',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget loginButton(WidgetRef ref) {
  //   return ActionButton(
  //     width: double.infinity,
  //     label: 'Forget Password',
  //     onPressed: () {

  //       // ref.read(authStateNotifierProvider.notifier).loginUser(
  //       //       usernameController.text,
  //       //       passwordController.text,
  //       //     );
  //     },
  //     textColor: AppColors.white,
  //   );
  // }
}
