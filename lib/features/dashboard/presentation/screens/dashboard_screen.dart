// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:app_version_update/app_version_update.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/filter_state_provider.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/services/location_service/presentation/map_notifier_provider.dart';
import 'package:findcarsale/services/notification_service.dart';
import 'package:findcarsale/services/push_notification_service.dart';
import 'package:findcarsale/shared/core/app_context.dart';
import 'package:findcarsale/shared/domain/circulat_indicator_widget.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import '../../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../../../shared/domain/models/user/user_model.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key, this.fromLogin = false});
  final bool fromLogin;

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final scrollController = ScrollController();

  final TextEditingController searchController = TextEditingController();
  int currentPageIndex = 0;

  final appleId =
      '6737464722'; // If this value is null, its packagename will be considered
  final playStoreId =
      'com.garageyard.garageyardsale'; // If this value is null, its packagename will be considered

  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        log('iosInfo: ${iosInfo.identifierForVendor}');
        return iosInfo.identifierForVendor ?? 'unknown_device';
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        log('androidInfo: ${androidInfo.id}');
        return androidInfo.id;
      }
    } catch (e) {
      // Handle any errors
    }

    return 'unknown_device';
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      checkForUpdate();
      ref.read(filterNotifierProvider.notifier).updateToInitial();
      ref.read(notificationServiceProvider).init(context);
      ref.read(pushNotificationProvider(context)).setupFirebaseMessage();
    });
  }

  checkForUpdate() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: appleId,
      playStoreId: playStoreId,
    ).then((data) async {
      if (data.canUpdate!) {
        AppVersionUpdate.showAlertUpdate(
          mandatory: true,
          appVersionResult: data,
          context: context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppContext.setContext(context);
    final currentUserAsyncValue = ref.watch(currentUserProvider);
    ref.listen(mapNotifierProvider, (previous, next) {});

    if (widget.fromLogin) {
      return AutoTabsRouter(
        // list of your tab routes
        // routes used here must be declared as children
        routes: const [ExploreScreen(), SalesScreen(), AccountScreen()],
        transitionBuilder:
            (context, child, animation) => FadeTransition(
              opacity: animation,
              // the passed child is technically our animated selected-tab page
              child: child,
            ),
        builder: (context, child) {
          // obtain the scoped TabsRouter controller using context
          final tabsRouter = AutoTabsRouter.of(context);
          // Here we're building our Scaffold inside of AutoTabsRouter
          // to access the tabsRouter controller provided in this context
          //
          // alternatively, you could use a global key
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.blue.withOpacity(0.2),
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
                  states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    );
                  }
                  return const TextStyle(
                    color: AppColors.unselectedTextColor,
                    fontWeight: FontWeight.w700,
                  );
                }),
              ),
              child: NavigationBar(
                backgroundColor: AppColors.surfaceLight,
                onDestinationSelected: (int index) async {
                  currentUserAsyncValue.when(
                    data: (User? data) async {
                      if (data == null && index == 1) {
                        context.router.push(LoginScreen());
                        return;
                      } else {
                        // if (index == 0) {
                        //   //reset data
                        //   ref
                        //       .read(filterNotifierProvider.notifier)
                        //       .updateToInitial();
                        //   await _handleLocationUpdate();
                        // }
                        tabsRouter.setActiveIndex(index);
                      }
                    },
                    error: (Object error, StackTrace stackTrace) {},
                    loading: () {},
                  );
                },
                selectedIndex: tabsRouter.activeIndex,
                destinations: const [
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.search,
                      color: AppColors.secondary,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: AppColors.unselectedTextColor,
                    ),
                    label: 'Explore',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.attach_money,
                      color: AppColors.secondary,
                    ),
                    icon: Icon(
                      Icons.attach_money,
                      color: AppColors.unselectedTextColor,
                    ),
                    label: 'My Sales',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.secondary,
                    ),
                    icon: Icon(
                      Icons.person_outline,
                      color: AppColors.unselectedTextColor,
                    ),
                    label: 'Account',
                  ),
                ],
                indicatorColor: AppColors.primaryContainer,
              ),
            ),
          );
        },
      );
    }

    return currentUserAsyncValue.when(
      data: (User? data) {
        return FutureBuilder<String>(
          future: _getDeviceId(),
          builder: (context, deviceIdSnapshot) {
            String userId =
                data?.userId.toString() ??
                (deviceIdSnapshot.data ?? 'unknown_device');

            return ClarityWidget(
              clarityConfig: ClarityConfig(
                projectId: "s38sq0gyz9",
                userId: userId,
                logLevel:
                    LogLevel
                        .None, // Note: Use "LogLevel.Verbose" value while testing to debug initialization issues.
              ),
              app: AutoTabsRouter(
                // list of your tab routes
                // routes used here must be declared as children
                routes: const [ExploreScreen(), SalesScreen(), AccountScreen()],
                transitionBuilder:
                    (context, child, animation) => FadeTransition(
                      opacity: animation,
                      // the passed child is technically our animated selected-tab page
                      child: child,
                    ),
                builder: (context, child) {
                  // obtain the scoped TabsRouter controller using context
                  final tabsRouter = AutoTabsRouter.of(context);
                  // Here we're building our Scaffold inside of AutoTabsRouter
                  // to access the tabsRouter controller provided in this context
                  //
                  // alternatively, you could use a global key
                  return Scaffold(
                    body: child,
                    bottomNavigationBar: NavigationBarTheme(
                      data: NavigationBarThemeData(
                        indicatorColor: Colors.blue.withOpacity(0.2),
                        labelTextStyle:
                            WidgetStateProperty.resolveWith<TextStyle>((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return const TextStyle(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                );
                              }
                              return const TextStyle(
                                color: AppColors.unselectedTextColor,
                                fontWeight: FontWeight.w700,
                              );
                            }),
                      ),
                      child: NavigationBar(
                        backgroundColor: AppColors.surfaceLight,
                        onDestinationSelected: (int index) async {
                          currentUserAsyncValue.when(
                            data: (User? data) async {
                              if (data == null && index == 1) {
                                context.router.push(LoginScreen());
                                return;
                              } else {
                                // if (index == 0) {
                                //   //reset data
                                //   ref
                                //       .read(filterNotifierProvider.notifier)
                                //       .updateToInitial();
                                //   await _handleLocationUpdate();
                                // }
                                tabsRouter.setActiveIndex(index);
                              }
                            },
                            error: (Object error, StackTrace stackTrace) {},
                            loading: () {},
                          );
                        },
                        selectedIndex: tabsRouter.activeIndex,
                        destinations: const [
                          NavigationDestination(
                            selectedIcon: Icon(
                              Icons.search,
                              color: AppColors.secondary,
                            ),
                            icon: Icon(
                              Icons.search,
                              color: AppColors.unselectedTextColor,
                            ),
                            label: 'Explore',
                          ),
                          NavigationDestination(
                            selectedIcon: Icon(
                              Icons.attach_money,
                              color: AppColors.secondary,
                            ),
                            icon: Icon(
                              Icons.attach_money,
                              color: AppColors.unselectedTextColor,
                            ),
                            label: 'My Sales',
                          ),
                          NavigationDestination(
                            selectedIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.secondary,
                            ),
                            icon: Icon(
                              Icons.person_outline,
                              color: AppColors.unselectedTextColor,
                            ),
                            label: 'Account',
                          ),
                        ],
                        indicatorColor: AppColors.primaryContainer,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const CircularIndicatorWidget();
      },
      loading: () {
        return const CircularIndicatorWidget();
      },
    );
  }
}
