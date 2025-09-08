import 'package:auto_route/auto_route.dart';
import 'package:findcarsale/routes/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreen.page, initial: true),
    AutoRoute(page: CustomIntroScreen.page),
    AutoRoute(page: LoginScreen.page),
    AutoRoute(page: ForgetEmailScreen.page),
    AutoRoute(page: SignupScreen.page),
    AutoRoute(page: CreateNewPasswordScreen.page),
    AutoRoute(
      page: DashboardScreen.page,
      children: [
        AutoRoute(page: ExploreScreen.page),
        AutoRoute(
          page: SalesScreen.page,
          children: [
            AutoRoute(page: ActiveSalesScreen.page),
            AutoRoute(page: ExpiredScreen.page),
          ],
        ),
        AutoRoute(page: AccountScreen.page),
      ],
    ),
    AutoRoute(page: AddEditPostSaleScreen.page),
    AutoRoute(page: PostDetailScreen.page),
    AutoRoute(page: DirectionScreen.page),
    AutoRoute(page: MyProfileScreen.page),
    AutoRoute(page: EditProfileScreen.page),
    AutoRoute(page: ChangePasswordScreen.page),
    AutoRoute(page: WebviewWidgetScreen.page),
    AutoRoute(page: AboutUsScreen.page),
    AutoRoute(page: TermsConditionScreen.page),
    AutoRoute(page: FeedbackScreen.page),
  ];
}

// import 'package:auto_route/auto_route.dart';
// import 'package:findcarsale/routes/app_route.gr.dart';

// @AutoRouterConfig(
//   replaceInRouteName: 'Page,Route',
// )
// class AppRouter extends RootStackRouter {
//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(page: SplashScreen.page, initial: true),
//         AutoRoute(page: SuccessScreen.page),
//         AutoRoute(page: CustomIntroScreen.page),
//         AutoRoute(
//           page: LoginScreen.page,
//         ),
//         AutoRoute(page: ForgetEmailScreen.page),
//         AutoRoute(page: SignupScreen.page),
//         AutoRoute(page: CreateNewPasswordScreen.page),
//         AutoRoute(page: DashboardScreen.page),
//         AutoRoute(page: AddPostSaleScreen.page),
//         AutoRoute(page: AccountScreen.page),
//         AutoRoute(page: EditProfileScreen.page),
//         AutoRoute(page: MyProfileScreen.page),
//         AutoRoute(page: ChangePasswordScreen.page),
//         AutoRoute(page: SearchEntityScreen.page),

//         AutoRoute(
//           page: PostDetailScreen.page,
//         ),

//         // AutoRoute(page: DirectionScreen.page),
//         // AutoRoute(page: MyProfileScreen.page),
//         AutoRoute(page: ExploreScreen.page),
//         AutoRoute(page: SalesScreen.page, children: [
//           AutoRoute(page: ActiveSalesScreen.page),
//           AutoRoute(page: ExpiredScreen.page),
//         ]),
//         // AutoRoute(page: AccountScreen.page),
//       ];
// }
