import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/providers/change_new_password_from_forgot_notifier_provider.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/password_field_widget.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/app_image.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import '../../../../shared/widgets/action_button.dart';
import '../../../authentication/presentation/widgets/auth_field.dart';

@RoutePage()
class CreateNewPasswordScreen extends ConsumerWidget {
  CreateNewPasswordScreen({super.key, this.email});
  final String? email;

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changeNewPasswordfromForgotPasswordProvider);
    ref.listen(changeNewPasswordfromForgotPasswordProvider, ((previous, next) {
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
          AutoRouter.of(context).replaceAll([LoginScreen()]);
        },
      );
    }));
    /*void _scrollToError() {
      // toastForClockout();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (formKey.currentState?.errors != null) {
          for (var field in formKey.currentState!.fields.values) {
            if (field.hasError) {
              final context = field.context;
              final box = context.findRenderObject() as RenderBox;
              final position = box.localToGlobal(Offset.zero);
              scrollController.animateTo(
                scrollController.offset + position.dy - 80,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              break;
            }
          }
        }
      });
    }
    */

    Widget loginButton(WidgetRef ref) {
      return ActionButton(
        width: double.infinity,
        label: 'Save',
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (formKey.currentState!.saveAndValidate()) {
            final mapData = {...formKey.currentState!.value};
            if (mapData['email'] == null) {
              mapData['email'] = email;
            }
            ref
                .read(changeNewPasswordfromForgotPasswordProvider.notifier)
                .changeNewPasswordFromForgotPassword(mapData);
          }
        },
        textColor: AppColors.white,
      );
    }

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
                          'New Password',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacing.sizedBoxH_16(),
                        Text(
                          'Please enter the PIN number that was sent to your email.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        Spacing.sizedBoxH_30(),
                        if ((email ?? '').isEmpty)
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
                        if ((email ?? '').isEmpty) Spacing.sizedBoxH_16(),
                        AuthField(
                          name: 'pin_number',
                          hintText: 'Pin Number',
                          labelText: 'Pin Number',
                          controller: pinController,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Pin Number is empty',
                            ),
                            FormBuilderValidators.numeric(
                              errorText: 'Pin Number must be numeric',
                            ),
                          ]),
                        ),
                        Spacing.sizedBoxH_16(),
                        PasswordFieldWidget(
                          name: 'new_password',
                          hintText: 'New Password',
                          labelText: 'Password',
                          passwordController: passwordController,
                        ),
                        Spacing.sizedBoxH_16(),
                        PasswordFieldWidget(
                          name: 'confirm_password',
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                          passwordController: confirmPasswordController,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Confirm Password is empty',
                            ),
                            (val) {
                              if (val?.trim() !=
                                  passwordController.text.trim()) {
                                return 'This does not match with new password';
                              }
                              return null;
                            },
                          ]),
                        ),
                        Spacing.sizedBoxH_40(),
                        loginButton(ref),
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
}
