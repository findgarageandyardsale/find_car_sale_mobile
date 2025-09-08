import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/account/presentation/providers/state/change_password_provider.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/password_field_widget.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import '../../../../shared/widgets/action_button.dart';
import '../../../../shared/widgets/custom_toast.dart';

@RoutePage()
class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentController = TextEditingController();
  final GlobalKey<FormBuilderState> _form = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changePasswordNotifierProvider);
    ref.listen(changePasswordNotifierProvider.select((value) => value), ((
      previous,
      next,
    ) {
      next.maybeWhen(
        orElse: () {},
        failure: (failure) {
          ref.read(changePasswordNotifierProvider.notifier).initState();
          CustomToast.showToast(
            failure.message.toString(),
            status: ToastStatus.error,
          );
        },
        success: (success) {
          ref.read(changePasswordNotifierProvider.notifier).initState();

          CustomToast.showToast(
            'Password changed successfully',
            status: ToastStatus.success,
          );
          //refetch data
          // ref.read(currentUserProvider).;
          Navigator.pop(context);
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
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: FormBuilder(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/launcher.png', height: 150, width: 150),
                    Spacing.sizedBoxH_36(),
                    Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Spacing.sizedBoxH_30(),
                    PasswordFieldWidget(
                      name: 'old_password',
                      hintText: 'Current Password',
                      labelText: 'Current Password',
                      passwordController: currentController,
                    ),
                    Spacing.sizedBoxH_16(),
                    PasswordFieldWidget(
                      name: 'new_password',
                      hintText: 'New Password',
                      labelText: 'New Password',
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
                          if (val?.trim() != passwordController.text.trim()) {
                            return 'This does not match with new password';
                          }
                          return null;
                        },
                      ]),
                    ),
                    Spacing.sizedBoxH_40(),
                    ActionButton(
                      width: double.infinity,
                      label: 'Change Password',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_form.currentState!.saveAndValidate()) {
                          final map = _form.currentState!.value;
                          ref
                              .read(changePasswordNotifierProvider.notifier)
                              .changePassword(map: map);
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
      ),
    );
  }
}
