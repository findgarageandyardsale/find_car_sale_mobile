import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/password_field_widget.dart';
import 'package:findcarsale/services/push_notification_service.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import '../../../../routes/app_route.gr.dart';
import '../../../../shared/widgets/action_button.dart';
import '../../../../shared/widgets/app_image.dart';
import '../providers/auth_providers.dart';
import '../providers/state/auth_state.dart';
import '../widgets/auth_field.dart';

@RoutePage()
class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authStateNotifierProvider);

    void setFilterInitail() {
      AutoRouter.of(
        context,
      ).replaceAll([DashboardScreen(fromLogin: true)]).then((_) {
        AutoTabsRouter.of(context).setActiveIndex(0);
      });
      ref.invalidate(currentUserProvider);
    }

    ref.listen(authStateNotifierProvider.select((value) => value), ((
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
        success: () {
          setFilterInitail();
        },
      );
    }));
    return CustomLoadingOverlay(
      isLoading: state is Loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
          leading: BackButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                setFilterInitail();
              }
            },
          ),
        ),
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
                        Text(
                          'Welcome',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Spacing.sizedBoxH_16(),
                        //     RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text: 'Welcome to ',
                        //     style: Theme.of(context).textTheme.headlineMedium,
                        //     children: const [
                        //       TextSpan(
                        //         text: 'Garage & Yard Sales',
                        //         style: TextStyle(color: AppColors.primary),
                        //       ),
                        //       TextSpan(text: '!'),
                        //     ],
                        //   ),
                        // ),
                        const AppImage(),
                        Spacing.sizedBoxH_36(),

                        // Spacing.sizedBoxH_16(),
                        // Text(
                        //   'Enter your login details to access your account',
                        //   style: Theme.of(context).textTheme.bodyMedium,
                        // ),
                        // Spacing.sizedBoxH_20(),
                        AuthField(
                          name: 'email',
                          hintText: 'Email',
                          labelText: 'Email',
                          controller: usernameController,
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
                        PasswordFieldWidget(
                          name: 'password',
                          hintText: 'Password',
                          autofillHints: const [AutofillHints.password],
                          labelText: 'Password',
                          passwordController: passwordController,
                        ),
                        // Spacing.sizedBoxH_16(),
                        // CheckboxListTile(
                        //   value: true,
                        //   // value: fromStorageValue.value == true
                        //   //     ? true
                        //   //     : rememberMe.value,
                        //   onChanged: (value) {

                        //   },
                        //   activeColor: AppColors.primary,
                        //   controlAffinity: ListTileControlAffinity.leading,
                        //   title: Text(
                        //     "Remember Me",
                        //     style: Theme.of(context).textTheme.titleSmall,
                        //   ),
                        // ),
                        Spacing.sizedBoxH_30(),
                        loginButton(context, ref),
                        Spacing.sizedBoxH_16(),
                        TextButton(
                          onPressed: () {
                            context.router.push(ForgetEmailScreen());
                          },
                          child: Text(
                            'Forget Password?',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Spacing.sizedBoxH_30(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don’t have an account?  ',
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      AutoRouter.of(
                                        context,
                                      ).push(SignupScreen());
                                    },
                                    child: Text(
                                      'Sign Up',
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

  Widget loginButton(BuildContext context, WidgetRef ref) {
    return ActionButton(
      width: double.infinity,
      label: 'Sign In',
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (formKey.currentState!.saveAndValidate()) {
          final fcmToken =
              await ref
                  .read(pushNotificationProvider(context))
                  .registerFCMToken();

          ref
              .read(authStateNotifierProvider.notifier)
              .loginUser(
                usernameController.text,
                passwordController.text,
                fcmToken: fcmToken,
              );
        }
      },
      textColor: AppColors.white,
    );
  }
}
