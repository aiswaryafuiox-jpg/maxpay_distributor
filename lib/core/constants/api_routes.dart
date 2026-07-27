class ApiRoutes {
  static const String baseURL = "http://139.59.91.7/test_paylinkonline.in/public";

  static const String loginSendOtp = "/api/distributor_login_sendotp";
  static const String verifyOtp = "/api/distributor_login_verifyOtp";
  static const String createPin = "/api/distributor_create_pin";
  static const String verifyPin = "/api/distributor_verify_pin";
  static const String updateFingerprint = "/api/distributor_update_fingerprint";
  static const String logout = "/api/distributor_logout";
}