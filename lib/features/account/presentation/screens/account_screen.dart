// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/presentation/providers/state/delete_account_provider.dart';
import 'package:findcarsale/features/account/presentation/providers/state/edit_profile_provider.dart';
import 'package:findcarsale/features/account/presentation/providers/state/get_profile_provider.dart';
import 'package:findcarsale/features/account/presentation/widgets/logout_dialog.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/services/push_notification_service.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/user/user_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/presentation/formz_state.dart';
import '../../../../shared/widgets/custom_loading.dart';
import '../widgets/circular_user_image_widget.dart';
import 'package:findcarsale/features/account/presentation/providers/state/logout_provider.dart';

@RoutePage()
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsyncValue = ref.watch(currentUserProvider);
    final state = ref.watch(deleteAccountNotifierProvider);
    final editstate = ref.watch(editProfileNotifierProvider);
    final logoutState = ref.watch(logoutNotifierProvider);

    ref.listen(deleteAccountNotifierProvider.select((value) => value), ((
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
          ref.read(userLocalRepositoryProvider).deleteUser();
          context.router.replaceAll([LoginScreen()]).then((_) {
            ref.invalidate(currentUserProvider);
          });
        },
      );
    }));

    ref.listen(editProfileNotifierProvider.select((value) => value), ((
      previous,
      next,
    ) {
      next.maybeWhen(
        orElse: () {},
        failure: (failure) {
          ref.read(editProfileNotifierProvider.notifier).initState();

          CustomToast.showToast(
            failure.message.toString(),
            status: ToastStatus.error,
          );
        },
        success: (success) {
          ref.read(editProfileNotifierProvider.notifier).initState();

          CustomToast.showToast(
            'Notification updated successfully',
            status: ToastStatus.success,
          );
          //get profile
          ref.read(getProfileNotifierProvider.notifier).getProfile();
        },
      );
    }));

    ref.listen(logoutNotifierProvider.select((value) => value), ((
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
          ref.read(userLocalRepositoryProvider).deleteUser();
          context.router.replaceAll([LoginScreen()]).then((_) {
            ref.invalidate(currentUserProvider);
          });
        },
      );
    }));

    Future<void> naviagtion(PageRouteInfo route) async {
      currentUserAsyncValue.when(
        data: (User? data) {
          if (data == null) {
            context.router.push(LoginScreen());
          } else {
            context.router.push(route);
          }
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {},
      );
    }

    void onShareApp() async {
      // A builder is used to retrieve the context immediately
      // surrounding the ElevatedButton.
      //
      // The context's `findRenderObject` returns the first
      // RenderObject in its descendent tree when it's not
      // a RenderObjectWidget. The ElevatedButton's RenderObject
      // has its position and size after it's built.
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        await Share.share(
          HelperConstant.playStoreAppStoreID,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        );
      }
    }

    // ignore: unused_element
    void shareLink() async {
      // showDialog(
      //   context: context,
      //   builder: (context) => const Center(
      //     child: CircularProgressIndicator(
      //       color: AppColors.primary,
      //     ),
      //   ),
      // );
      // currentUserAsyncValue.when(
      //     data: (User? data) async {
      //       if (data == null) {
      //         BranchUniversalObject buo = BranchUniversalObject(
      //           canonicalIdentifier: 'flutter/branch',
      //           title: '${data?.firstName} ${data?.lastName}',
      //           imageUrl: '${AppConfigs.baseUrl}${data?.images}}',
      //           publiclyIndex: true,
      //           locallyIndex: true,
      //           contentMetadata: BranchContentMetaData()
      //             ..addCustomMetadata(userId, data?.userId.toString()),
      //         );
      //         BranchLinkProperties lp = BranchLinkProperties(
      //             channel: 'facebook',
      //             feature: 'sharing',
      //             stage: 'new share',
      //             tags: ['one', 'two', 'three']);
      //         lp.addControlParam('url', 'http://www.google.com');
      //         lp.addControlParam('url2', 'http://flutter.dev');
      //         BranchResponse response = await FlutterBranchSdk.getShortUrl(
      //             buo: buo, linkProperties: lp);
      //         if (response.success) {
      //           final box = context.findRenderObject() as RenderBox?;
      //           final size = MediaQuery.of(context).size;

      //           Share.share(
      //             'Check out this amazing profile ${response.result}',
      //             subject: 'Look ${data?.firstName} ${data?.lastName}',
      //             sharePositionOrigin: box!.localToGlobal(Offset.zero) &
      //                 Size(size.height / 2, size.width),
      //           );
      //         } else {
      //           PrintUtils.customLog(
      //               'Error : ${response.errorCode} - ${response.errorMessage}');
      //         }
      //       }
      //     },
      //     error: (error, __) {
      //       return const Text('Error');
      //     },
      //     loading: () {});

      // Navigator.of(context).pop();
    }

    Future<void> launchTermsAndConditionUrl() async {
      final Uri url = Uri.parse(HelperConstant.termsAndConditions);

      if (!await launchUrl(url)) {
        throw Exception(
          'Could not launch ${HelperConstant.termsAndConditions}',
        );
      }
    }

    return CustomLoadingOverlay(
      isLoading:
          state is Loading || editstate is Loading || logoutState is Loading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  currentUserAsyncValue.when(
                    data: (User? data) {
                      if (data == null) {
                        return InkWell(
                          onTap: () {
                            context.router.push(LoginScreen());
                          },
                          child: Row(
                            children: [
                              Spacing.sizedBoxW_06(),
                              const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryContainer,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 28,
                                  color: AppColors.black,
                                ),
                              ),
                              Spacing.sizedBoxW_16(),
                              Flexible(
                                child: Text(
                                  'Guest',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Spacing.sizedBoxW_12(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              context.router.push(const MyProfileScreen());
                            },
                            child: Row(
                              children: [
                                Spacing.sizedBoxW_06(),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.primaryContainer,
                                  child: CircularUserImageWidget(
                                    firstName: data.firstName,
                                    lastName: data.lastName,
                                    file: data.profile?.file,
                                  ),
                                ),
                                Spacing.sizedBoxW_16(),
                                Flexible(
                                  child: Text(
                                    '${data.firstName} ${data.lastName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Spacing.sizedBoxW_12(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                          Spacing.sizedBoxH_36(),
                          ListTile(
                            onTap: () {},
                            leading: const Icon(Icons.notifications_outlined),
                            title: Text(
                              'Notification',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Switch.adaptive(
                              padding: const EdgeInsets.all(2),
                              value: data.notification ?? false,
                              onChanged: (val) {
                                Map<String, dynamic> map = {};
                                map.addAll(data.toJson());
                                map.addAll({'notification': val});
                                ref
                                    .read(editProfileNotifierProvider.notifier)
                                    .editProfile(
                                      map: map,
                                      userId: (data.userId ?? '').toString(),
                                    );
                              },
                            ),
                          ),
                          CustomListTileWidget(
                            icon: Icons.password,
                            title: 'Change Password',
                            onTap: () async {
                              naviagtion(ChangePasswordScreen());
                            },
                          ),
                        ],
                      );
                    },
                    error: (error, __) {
                      return const Text('Error');
                    },
                    loading: () {
                      return Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          );
                    },
                  ),
                  CustomListTileWidget(
                    icon: Icons.share_outlined,
                    title: 'Share App',
                    onTap: () {
                      // shareLink();
                      onShareApp();
                    },
                  ),
                  CustomListTileWidget(
                    icon: Icons.info_outline,
                    title: 'About Us',
                    onTap: () {
                      context.router.push(const AboutUsScreen());
                    },
                  ),
                  CustomListTileWidget(
                    icon: Icons.insert_drive_file_outlined,
                    title: 'Terms and Policy',
                    onTap: () {
                      launchTermsAndConditionUrl();
                    },
                  ),
                  currentUserAsyncValue.when(
                    data: (User? data) {
                      if (data == null) {
                        return const SizedBox.shrink();
                      }
                      return CustomListTileWidget(
                        icon: Icons.feedback_outlined,
                        title: 'Feedback',
                        onTap: () {
                          naviagtion(FeedbackScreen());
                        },
                      );
                    },
                    error: (error, __) {
                      return const Text('Error');
                    },
                    loading: () {
                      return Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          );
                    },
                  ),
                  const Divider(color: AppColors.lightGrey, thickness: 1),
                  currentUserAsyncValue.when(
                    data: (User? data) {
                      if (data == null) {
                        return CustomListTileWidget(
                          icon: Icons.login,
                          title: 'Sign In',
                          onTap: () {
                            context.router.push(LoginScreen());
                          },
                        );
                      }
                      return CustomListTileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onTap: () {
                          logOutDialogWidget(
                            context: context,
                            logoutFunction: () async {
                              final fcmToken =
                                  await ref
                                      .read(pushNotificationProvider(context))
                                      .registerFCMToken();
                              ref
                                  .read(logoutNotifierProvider.notifier)
                                  .logout(token: fcmToken);
                            },
                          );
                        },
                      );
                    },
                    error: (error, __) {
                      return const Text('Error');
                    },
                    loading: () {
                      return Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          );
                    },
                  ),
                  currentUserAsyncValue.when(
                    data: (User? data) {
                      if (data == null) {
                        return const SizedBox.shrink();
                      }
                      return CustomListTileWidget(
                        icon: Icons.delete_outline,
                        title: 'Delete Account',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 24,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        size: 60,
                                        color: Colors.red,
                                      ),
                                      Spacing.sizedBoxH_16(),
                                      Text(
                                        'Delete Account?',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall!.copyWith(
                                          color: AppColors.surface,
                                          height: 1.43,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Spacing.sizedBoxH_08(),
                                      Text(
                                        'Are you sure you want to delete your account?',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium!.copyWith(
                                          color: AppColors.surface,
                                          height: 1.5,
                                          letterSpacing: 0.4,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Spacing.sizedBoxH_20(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            child: Text(
                                              'Cancel',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                          Spacing.sizedBoxW_16(),
                                          TextButton(
                                            child: Text(
                                              'Confirm',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.copyWith(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              ref
                                                  .read(
                                                    deleteAccountNotifierProvider
                                                        .notifier,
                                                  )
                                                  .deleteAccount(
                                                    id:
                                                        (data.userId ?? '')
                                                            .toString(),
                                                  );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                      );
                    },
                    error: (error, __) {
                      return const Text('Error');
                    },
                    loading: () {
                      return Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          );
                    },
                  ),
                  Spacing.sizedBoxH_20(),
                  const VersionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VersionWidget extends StatefulWidget {
  const VersionWidget({super.key});

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  String? versionName;

  void packageInfo() async {
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        versionName = '${packageInfo.version} (${packageInfo.buildNumber})';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    packageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return (versionName ?? '').trim().isEmpty
        ? const SizedBox.shrink()
        : ListTile(
          leading: const Icon(Icons.numbers, color: AppColors.lightGrey),
          title: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Version ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.lightGrey),
                ),
                TextSpan(
                  text: '$versionName',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
