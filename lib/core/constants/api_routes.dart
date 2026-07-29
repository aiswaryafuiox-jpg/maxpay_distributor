class ApiRoutes {
  static const baseURL = "http://139.59.91.7/test_paylinkonline.in/public";
  // static const comURL = "https://beforeafternutrition.fuiox.com/storage";

  static const getWalletCreditType = "/api/distributor_wallet_credit_types";
  static const distributorTransferTypes = "/api/distributor_transfer_types";
  static const String loginSendOtp = "/api/distributor_login_sendotp";
  static const String verifyOtp = "/api/distributor_login_verifyOtp";
  static const String createPin = "/api/distributor_create_pin";
  static const String verifyPin = "/api/distributor_verify_pin";
  static const String updateFingerprint = "/api/distributor_update_fingerprint";
  static const String logout = "/api/distributor_logout";
  static const String getProfile = "/api/distributor_get_profile";
  static const String updateProfile = "/api/distributor_update_profile";
  static const String updateProfileVerifyOtp =
      "/api/distributor_update_profile_verify_otp";
  static const String updateProfileResendOtp =
      "/api/distributor_update_profile_resend_otp";
  static const String updateStatusSendOtp =
      "/api/distributor_update_status_send_otp";
  static const String updateStatusVerifyOtp =
      "/api/distributor_update_status_verify_otp";
  static const String getRetailers = "/api/distributor_retailers";
  static const String getRetailerDetail = "/api/distributor_retailer_detail";
  static const String getCommissionPackages =
      "/api/distributor_commission_packages";
  static const String createRetailer = "/api/distributor_create_retailer";
  static const String updateRetailer = "/api/distributor_update_retailer";
  static const String getAddWalletDetails =
      "/api/distributor_add_wallet_details";
  static const String addWallet = "/api/distributor_add_wallet";
  static const String getExecutives = "/api/distributor_executives";
  static const String getExecutiveDetail = "/api/distributor_executive_detail";
  static const String getExecutiveCommissionPackages = "/api/distributor_executive_commission_packages";
  static const String updateExecutive = "/api/distributor_update_executive";
  static const String addExecutiveWalletDetails = "/api/distributor_add_executive_wallet_details";
  static const String addExecutiveWallet = "/api/distributor_add_executive_wallet";
  static const String transactionProducts = "/api/distributor_transaction_products";
  static const String transactionReport = "/api/distributor_transaction_report";
  static const String transactionDetail = "/api/distributor_transaction_detail";
}
