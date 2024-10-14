class ApiRoutes {
  static const String baseUrl = 'https://conciergebooking.tijarah.ae/api/';
  static const String resendOtpUrl = '${baseUrl}user/resend/otp';
  static const String verifyOtpUrl = '${baseUrl}user/verify/email';
  static const String sendOtpForgotPassword= '${baseUrl}user/forgot/password';
  static const String verifyOtpUrlForgotPassword = '${baseUrl}user/verify/code';
}
