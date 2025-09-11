class AppConfigs {
  // http://54.146.185.244/api/v1/find/car/sales/
  static String url = 'http://54.146.185.244:8000';
  // static String url = 'http://127.0.0.1:8000';
  ///http://127.0.0.1:8000/api/v1/home/user/login/
  static String baseUrl = '$url/api/v1';

  static String loginEndpoint = '/home/user/login/';
  static String signupEndpoint = '/user/';

  static String requestEmailforgotPassword = '/user/password_forgot/';
  static String changeforgotPassword = '/user/forgot_password/';

  static String postSearchEndpoint = '/posts/search';

  static String yardSaleEndpoint = '/find/car/sales/';
  static String mySaleEndpoint = '/find/car/sales/my/sales/';

  static String changePasswordEndpoint = '/user/changed_password/';
  static String uploadAttachment = '/attachment/save_attachment/';
  static String postFeedback = '/garage/yard/rating/';

  static String getUserEndpoint({required String id}) => '/user/$id/';
  static String profileEndpoint = '/user/profile/';
  static String logout = '/home/user/logout/';
  static String createSales = 'find/car/sales/';
  static String payementSales = '/garage/yard/payment/';
  static String getCarCondition = '/find/carsale/conditions/';

  static String stripeEndpoint = 'https://api.stripe.com/v1/payment_intents';
}
