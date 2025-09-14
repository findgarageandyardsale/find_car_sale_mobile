import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HelperConstant {
  static bool get isForTest => dotenv.env['APP_ENVIRONMENT'] == 'test';

  static String get stripeToken =>
      isForTest
          ? dotenv.env['STRIPE_TEST_SECRET_KEY'] ?? ''
          : dotenv.env['STRIPE_LIVE_SECRET_KEY'] ?? '';

  static String get publishableStripeKey =>
      isForTest
          ? dotenv.env['STRIPE_TEST_PUBLISHABLE_KEY'] ?? ''
          : dotenv.env['STRIPE_LIVE_PUBLISHABLE_KEY'] ?? '';

  static String get merchantIdentifier =>
      isForTest
          ? dotenv.env['STRIPE_TEST_MERCHANT_ID'] ?? ''
          : dotenv.env['STRIPE_LIVE_MERCHANT_ID'] ?? '';

  static String playStoreAppStoreID =
      Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=com.garageyard.garageyardsale'
          : 'https://apps.apple.com/us/app/findcarsale/6737464722';

  static String termsAndConditions =
      'https://findgarageandyardsale.com/#/terms-and-conditions';
  static String privacyPolicy =
      'https://findgarageandyardsale.com/#/privacy-policy';
  static String postPrice = '5';

  static int priceForEach = 5;
  static String fixPrice = '5';

  static bool isPaymentRequired = false;
}
