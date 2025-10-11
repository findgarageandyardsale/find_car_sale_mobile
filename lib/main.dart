import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/firebase_options.dart';
import 'package:findcarsale/observers.dart';
import 'package:findcarsale/services/fcm_notification_service.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'routes/app_route.dart';
import 'shared/theme/app_theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// Background message handler for FCM
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  PrintUtils.customLog(
    "🔔 FCM: Handling background message: ${message.messageId}",
  );
  PrintUtils.customLog("🔔 FCM: Title: ${message.notification?.title}");
  PrintUtils.customLog("🔔 FCM: Body: ${message.notification?.body}");
  PrintUtils.customLog("🔔 FCM: Data: ${message.data}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    PrintUtils.customLog("Firebase initialized successfully");
  } catch (e) {
    PrintUtils.customLog("Firebase initialization failed $e");
    // Don't continue if Firebase fails to initialize
    rethrow;
  }

  try {
    Stripe.publishableKey = HelperConstant.publishableStripeKey;
    Stripe.merchantIdentifier = HelperConstant.merchantIdentifier;
    await Stripe.instance.applySettings();
  } catch (_) {
    PrintUtils.customLog("Stripe initialization failed");
  }

  // Initialize FCM
  try {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    PrintUtils.customLog("FCM background handler registered");
  } catch (e) {
    PrintUtils.customLog("FCM initialization failed: $e");
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(ProviderScope(observers: [Observers()], child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    // Initialize FCM service
    ref.read(fcmNotificationServiceProvider);

    return OKToast(
      child: MaterialApp.router(
        title: 'Find Car Sale',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          final MediaQueryData data = MediaQuery.of(context);

          return ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 600, name: MOBILE),
              const Breakpoint(start: 601, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1200, name: DESKTOP),
            ],
            child: MediaQuery(
              data: data.copyWith(textScaler: const TextScaler.linear(1.1)),
              child: widget!, // updated line
            ),
          );
        },
      ),
    );
  }
}
