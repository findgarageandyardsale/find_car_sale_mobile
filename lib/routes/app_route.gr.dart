// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:findcarsale/features/account/presentation/screens/about_us_screen.dart'
    as _i1;
import 'package:findcarsale/features/account/presentation/screens/account_screen.dart'
    as _i2;
import 'package:findcarsale/features/account/presentation/screens/change_password_screen.dart'
    as _i5;
import 'package:findcarsale/features/account/presentation/screens/edit_profile_screen.dart'
    as _i10;
import 'package:findcarsale/features/account/presentation/screens/feedback_screen.dart'
    as _i13;
import 'package:findcarsale/features/account/presentation/screens/my_profile_screen.dart'
    as _i16;
import 'package:findcarsale/features/account/presentation/screens/terms_condition_screen.dart'
    as _i23;
import 'package:findcarsale/features/add_edit_sale/presentation/screens/add_edit_post_sale_screen.dart'
    as _i4;
import 'package:findcarsale/features/authentication/presentation/screens/create_new_password_screen.dart'
    as _i6;
import 'package:findcarsale/features/authentication/presentation/screens/forget_email_screen.dart'
    as _i14;
import 'package:findcarsale/features/authentication/presentation/screens/login_screen.dart'
    as _i15;
import 'package:findcarsale/features/authentication/presentation/screens/signup_screen.dart'
    as _i20;
import 'package:findcarsale/features/authentication/presentation/screens/success_screen.dart'
    as _i22;
import 'package:findcarsale/features/dashboard/presentation/screens/dashboard_screen.dart'
    as _i8;
import 'package:findcarsale/features/explore/presentation/screens/explore_screen.dart'
    as _i12;
import 'package:findcarsale/features/explore/presentation/screens/search_entity_screen.dart'
    as _i19;
import 'package:findcarsale/features/post_detail/presentation/screens/direction_screen.dart'
    as _i9;
import 'package:findcarsale/features/post_detail/presentation/screens/post_detail_screen.dart'
    as _i17;
import 'package:findcarsale/features/sales/presentation/screens/active_sales_screen.dart'
    as _i3;
import 'package:findcarsale/features/sales/presentation/screens/expired_screen.dart'
    as _i11;
import 'package:findcarsale/features/sales/presentation/screens/sales_screen.dart'
    as _i18;
import 'package:findcarsale/features/splash/presentation/screens/custom_intro_screen.dart'
    as _i7;
import 'package:findcarsale/features/splash/presentation/screens/splash_screen.dart'
    as _i21;
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart'
    as _i27;
import 'package:findcarsale/shared/widgets/webview_widget_screen.dart' as _i24;
import 'package:flutter/foundation.dart' as _i28;
import 'package:flutter/material.dart' as _i26;

/// generated route for
/// [_i1.AboutUsScreen]
class AboutUsScreen extends _i25.PageRouteInfo<void> {
  const AboutUsScreen({List<_i25.PageRouteInfo>? children})
    : super(AboutUsScreen.name, initialChildren: children);

  static const String name = 'AboutUsScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutUsScreen();
    },
  );
}

/// generated route for
/// [_i2.AccountScreen]
class AccountScreen extends _i25.PageRouteInfo<void> {
  const AccountScreen({List<_i25.PageRouteInfo>? children})
    : super(AccountScreen.name, initialChildren: children);

  static const String name = 'AccountScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountScreen();
    },
  );
}

/// generated route for
/// [_i3.ActiveSalesScreen]
class ActiveSalesScreen extends _i25.PageRouteInfo<void> {
  const ActiveSalesScreen({List<_i25.PageRouteInfo>? children})
    : super(ActiveSalesScreen.name, initialChildren: children);

  static const String name = 'ActiveSalesScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i3.ActiveSalesScreen();
    },
  );
}

/// generated route for
/// [_i4.AddEditPostSaleScreen]
class AddEditPostSaleScreen
    extends _i25.PageRouteInfo<AddEditPostSaleScreenArgs> {
  AddEditPostSaleScreen({
    _i26.Key? key,
    _i27.Garageayard? garageayard,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         AddEditPostSaleScreen.name,
         args: AddEditPostSaleScreenArgs(key: key, garageayard: garageayard),
         initialChildren: children,
       );

  static const String name = 'AddEditPostSaleScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditPostSaleScreenArgs>(
        orElse: () => const AddEditPostSaleScreenArgs(),
      );
      return _i4.AddEditPostSaleScreen(
        key: args.key,
        garageayard: args.garageayard,
      );
    },
  );
}

class AddEditPostSaleScreenArgs {
  const AddEditPostSaleScreenArgs({this.key, this.garageayard});

  final _i26.Key? key;

  final _i27.Garageayard? garageayard;

  @override
  String toString() {
    return 'AddEditPostSaleScreenArgs{key: $key, garageayard: $garageayard}';
  }
}

/// generated route for
/// [_i5.ChangePasswordScreen]
class ChangePasswordScreen
    extends _i25.PageRouteInfo<ChangePasswordScreenArgs> {
  ChangePasswordScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        ChangePasswordScreen.name,
        args: ChangePasswordScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ChangePasswordScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangePasswordScreenArgs>(
        orElse: () => const ChangePasswordScreenArgs(),
      );
      return _i5.ChangePasswordScreen(key: args.key);
    },
  );
}

class ChangePasswordScreenArgs {
  const ChangePasswordScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ChangePasswordScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.CreateNewPasswordScreen]
class CreateNewPasswordScreen
    extends _i25.PageRouteInfo<CreateNewPasswordScreenArgs> {
  CreateNewPasswordScreen({
    _i26.Key? key,
    String? email,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         CreateNewPasswordScreen.name,
         args: CreateNewPasswordScreenArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'CreateNewPasswordScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateNewPasswordScreenArgs>(
        orElse: () => const CreateNewPasswordScreenArgs(),
      );
      return _i6.CreateNewPasswordScreen(key: args.key, email: args.email);
    },
  );
}

class CreateNewPasswordScreenArgs {
  const CreateNewPasswordScreenArgs({this.key, this.email});

  final _i26.Key? key;

  final String? email;

  @override
  String toString() {
    return 'CreateNewPasswordScreenArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i7.CustomIntroScreen]
class CustomIntroScreen extends _i25.PageRouteInfo<void> {
  const CustomIntroScreen({List<_i25.PageRouteInfo>? children})
    : super(CustomIntroScreen.name, initialChildren: children);

  static const String name = 'CustomIntroScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i7.CustomIntroScreen();
    },
  );
}

/// generated route for
/// [_i8.DashboardScreen]
class DashboardScreen extends _i25.PageRouteInfo<DashboardScreenArgs> {
  DashboardScreen({
    _i26.Key? key,
    bool fromLogin = false,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         DashboardScreen.name,
         args: DashboardScreenArgs(key: key, fromLogin: fromLogin),
         initialChildren: children,
       );

  static const String name = 'DashboardScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DashboardScreenArgs>(
        orElse: () => const DashboardScreenArgs(),
      );
      return _i8.DashboardScreen(key: args.key, fromLogin: args.fromLogin);
    },
  );
}

class DashboardScreenArgs {
  const DashboardScreenArgs({this.key, this.fromLogin = false});

  final _i26.Key? key;

  final bool fromLogin;

  @override
  String toString() {
    return 'DashboardScreenArgs{key: $key, fromLogin: $fromLogin}';
  }
}

/// generated route for
/// [_i9.DirectionScreen]
class DirectionScreen extends _i25.PageRouteInfo<void> {
  const DirectionScreen({List<_i25.PageRouteInfo>? children})
    : super(DirectionScreen.name, initialChildren: children);

  static const String name = 'DirectionScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i9.DirectionScreen();
    },
  );
}

/// generated route for
/// [_i10.EditProfileScreen]
class EditProfileScreen extends _i25.PageRouteInfo<void> {
  const EditProfileScreen({List<_i25.PageRouteInfo>? children})
    : super(EditProfileScreen.name, initialChildren: children);

  static const String name = 'EditProfileScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i10.EditProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.ExpiredScreen]
class ExpiredScreen extends _i25.PageRouteInfo<void> {
  const ExpiredScreen({List<_i25.PageRouteInfo>? children})
    : super(ExpiredScreen.name, initialChildren: children);

  static const String name = 'ExpiredScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i11.ExpiredScreen();
    },
  );
}

/// generated route for
/// [_i12.ExploreScreen]
class ExploreScreen extends _i25.PageRouteInfo<void> {
  const ExploreScreen({List<_i25.PageRouteInfo>? children})
    : super(ExploreScreen.name, initialChildren: children);

  static const String name = 'ExploreScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i12.ExploreScreen();
    },
  );
}

/// generated route for
/// [_i13.FeedbackScreen]
class FeedbackScreen extends _i25.PageRouteInfo<FeedbackScreenArgs> {
  FeedbackScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        FeedbackScreen.name,
        args: FeedbackScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'FeedbackScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedbackScreenArgs>(
        orElse: () => const FeedbackScreenArgs(),
      );
      return _i13.FeedbackScreen(key: args.key);
    },
  );
}

class FeedbackScreenArgs {
  const FeedbackScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'FeedbackScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.ForgetEmailScreen]
class ForgetEmailScreen extends _i25.PageRouteInfo<ForgetEmailScreenArgs> {
  ForgetEmailScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        ForgetEmailScreen.name,
        args: ForgetEmailScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ForgetEmailScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgetEmailScreenArgs>(
        orElse: () => const ForgetEmailScreenArgs(),
      );
      return _i14.ForgetEmailScreen(key: args.key);
    },
  );
}

class ForgetEmailScreenArgs {
  const ForgetEmailScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'ForgetEmailScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.LoginScreen]
class LoginScreen extends _i25.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        LoginScreen.name,
        args: LoginScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginScreenArgs>(
        orElse: () => const LoginScreenArgs(),
      );
      return _i15.LoginScreen(key: args.key);
    },
  );
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'LoginScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.MyProfileScreen]
class MyProfileScreen extends _i25.PageRouteInfo<void> {
  const MyProfileScreen({List<_i25.PageRouteInfo>? children})
    : super(MyProfileScreen.name, initialChildren: children);

  static const String name = 'MyProfileScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i16.MyProfileScreen();
    },
  );
}

/// generated route for
/// [_i17.PostDetailScreen]
class PostDetailScreen extends _i25.PageRouteInfo<PostDetailScreenArgs> {
  PostDetailScreen({
    _i28.Key? key,
    required _i27.Garageayard garageayard,
    bool? isActive,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         PostDetailScreen.name,
         args: PostDetailScreenArgs(
           key: key,
           garageayard: garageayard,
           isActive: isActive,
         ),
         initialChildren: children,
       );

  static const String name = 'PostDetailScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostDetailScreenArgs>();
      return _i17.PostDetailScreen(
        key: args.key,
        garageayard: args.garageayard,
        isActive: args.isActive,
      );
    },
  );
}

class PostDetailScreenArgs {
  const PostDetailScreenArgs({
    this.key,
    required this.garageayard,
    this.isActive,
  });

  final _i28.Key? key;

  final _i27.Garageayard garageayard;

  final bool? isActive;

  @override
  String toString() {
    return 'PostDetailScreenArgs{key: $key, garageayard: $garageayard, isActive: $isActive}';
  }
}

/// generated route for
/// [_i18.SalesScreen]
class SalesScreen extends _i25.PageRouteInfo<void> {
  const SalesScreen({List<_i25.PageRouteInfo>? children})
    : super(SalesScreen.name, initialChildren: children);

  static const String name = 'SalesScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i18.SalesScreen();
    },
  );
}

/// generated route for
/// [_i19.SearchEntityScreen]
class SearchEntityScreen extends _i25.PageRouteInfo<SearchEntityScreenArgs> {
  SearchEntityScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        SearchEntityScreen.name,
        args: SearchEntityScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SearchEntityScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchEntityScreenArgs>(
        orElse: () => const SearchEntityScreenArgs(),
      );
      return _i19.SearchEntityScreen(key: args.key);
    },
  );
}

class SearchEntityScreenArgs {
  const SearchEntityScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'SearchEntityScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.SignupScreen]
class SignupScreen extends _i25.PageRouteInfo<SignupScreenArgs> {
  SignupScreen({_i26.Key? key, List<_i25.PageRouteInfo>? children})
    : super(
        SignupScreen.name,
        args: SignupScreenArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignupScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignupScreenArgs>(
        orElse: () => const SignupScreenArgs(),
      );
      return _i20.SignupScreen(key: args.key);
    },
  );
}

class SignupScreenArgs {
  const SignupScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'SignupScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.SplashScreen]
class SplashScreen extends _i25.PageRouteInfo<void> {
  const SplashScreen({List<_i25.PageRouteInfo>? children})
    : super(SplashScreen.name, initialChildren: children);

  static const String name = 'SplashScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i21.SplashScreen();
    },
  );
}

/// generated route for
/// [_i22.SuccessScreen]
class SuccessScreen extends _i25.PageRouteInfo<SuccessScreenArgs> {
  SuccessScreen({
    _i26.Key? key,
    bool? fromLogin,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         SuccessScreen.name,
         args: SuccessScreenArgs(key: key, fromLogin: fromLogin),
         initialChildren: children,
       );

  static const String name = 'SuccessScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuccessScreenArgs>(
        orElse: () => const SuccessScreenArgs(),
      );
      return _i22.SuccessScreen(key: args.key, fromLogin: args.fromLogin);
    },
  );
}

class SuccessScreenArgs {
  const SuccessScreenArgs({this.key, this.fromLogin});

  final _i26.Key? key;

  final bool? fromLogin;

  @override
  String toString() {
    return 'SuccessScreenArgs{key: $key, fromLogin: $fromLogin}';
  }
}

/// generated route for
/// [_i23.TermsConditionScreen]
class TermsConditionScreen extends _i25.PageRouteInfo<void> {
  const TermsConditionScreen({List<_i25.PageRouteInfo>? children})
    : super(TermsConditionScreen.name, initialChildren: children);

  static const String name = 'TermsConditionScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i23.TermsConditionScreen();
    },
  );
}

/// generated route for
/// [_i24.WebviewWidgetScreen]
class WebviewWidgetScreen extends _i25.PageRouteInfo<WebviewWidgetScreenArgs> {
  WebviewWidgetScreen({
    _i26.Key? key,
    String title = 'Document Files',
    String type = 'url',
    required String data,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         WebviewWidgetScreen.name,
         args: WebviewWidgetScreenArgs(
           key: key,
           title: title,
           type: type,
           data: data,
         ),
         initialChildren: children,
       );

  static const String name = 'WebviewWidgetScreen';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebviewWidgetScreenArgs>();
      return _i24.WebviewWidgetScreen(
        key: args.key,
        title: args.title,
        type: args.type,
        data: args.data,
      );
    },
  );
}

class WebviewWidgetScreenArgs {
  const WebviewWidgetScreenArgs({
    this.key,
    this.title = 'Document Files',
    this.type = 'url',
    required this.data,
  });

  final _i26.Key? key;

  final String title;

  final String type;

  final String data;

  @override
  String toString() {
    return 'WebviewWidgetScreenArgs{key: $key, title: $title, type: $type, data: $data}';
  }
}
