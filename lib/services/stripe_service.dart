import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:findcarsale/configs/app_configs.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  String transactionId = "";

  Future<String?> makePayment() async {
    try {
      final int postPriceinInt = int.tryParse(HelperConstant.postPrice) ?? 10;

      PrintUtils.customLog(postPriceinInt.toString());
      PrintUtils.customLog(HelperConstant.postPrice.toString());
      PrintUtils.customLog('------------------');
      final String? paymentIntentClientSecret = await _createPaymentIntent(
        postPriceinInt,
        "usd",
      );
      if (paymentIntentClientSecret == null) {
        throw Exception('Failed to create PaymentIntent');
      }

      final paymentIntent = await retrievePaymentIntent(
        paymentIntentClientSecret,
      );

      if (paymentIntent != null &&
          paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        return paymentIntent.id;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,

          billingDetailsCollectionConfiguration:
              const BillingDetailsCollectionConfiguration(
                name: CollectionMode.always,
                email: CollectionMode.always,
                phone: CollectionMode.always,
                address: AddressCollectionMode.full,
              ),
          merchantDisplayName: "Susan Timilsina",
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: AppColors.primary),
          ),
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode: 'usd',
            testEnv: true,
          ),
        ),
      );

      // await _processPayment();
      await Stripe.instance.presentPaymentSheet();
      final updatedPaymentIntent = await retrievePaymentIntent(
        paymentIntentClientSecret,
      );

      if (updatedPaymentIntent != null) {
        if (updatedPaymentIntent.status == PaymentIntentsStatus.Succeeded) {
          return updatedPaymentIntent.id;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<PaymentIntent?> retrievePaymentIntent(String clientSecreateID) async {
    try {
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        clientSecreateID,
      );
      return paymentIntent;
    } catch (e) {
      PrintUtils.customLog('Error retrieving PaymentIntent: $e');
      return null;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      String stripToken = HelperConstant.stripeToken;
      var response = await dio.post(
        AppConfigs.stripeEndpoint,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripToken",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        transactionId = response.data["id"]; // Payment ID

        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Future<void> _processPayment() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();

  //     await Stripe.instance.confirmPaymentSheetPayment();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<PaymentIntent> confirmPayment(String paymentIntentClientSecret) async {
    final data = await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: paymentIntentClientSecret,
    );
    return data;
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
