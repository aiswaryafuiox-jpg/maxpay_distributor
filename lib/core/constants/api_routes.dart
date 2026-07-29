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




  static const distributorTransferDetail = "/api/distributor_transfer_detail";
  
  static const String distributorPendingWalletRequests = "/api/distributor_pending_wallet_requests";
  static const String distributorPendingWalletRequestDetail = "/api/distributor_pending_wallet_request_detail";
  static const String distributorApprovePendingWalletRequest = "/api/distributor_approve_pending_wallet_request";
  static const String distributorOutstandingList = "/api/distributor_outstanding_list";
  static const String distributorUpdateOutstanding = "/api/distributor_update_outstanding";
  static const String distributorLowWalletRetailers = "/api/distributor_low_wallet_retailers";
  
  static const String distributorWalletCreditList = '/api/distributor_wallet_credit';
  static const String distributorAutoTransferDetails = '/api/distributor_auto_transfer_details';
  static const String distributorUpdateAutoTransfer = '/api/distributor_update_auto_transfer';
  static const String distributorDayBookProducts = '/api/distributor_day_book_products';
  static const String distributorDayBookList = '/api/distributor_day_book';
  static const String distributorDayBookDelete = '/api/distributor_day_book_delete';
  static const String distributorMyEarnings = '/api/distributor_my_earnings';
  static const String distributorTransactionSuccessReport = '/api/distributor_transaction_success_report';
  static const String distributorCashBackProductTypes = '/api/distributor_cash_back_product_types';
  static const String distributorCashBack = '/api/distributor_cash_back';
  static const String distributorCommissionSettings = '/api/distributor_commission_settings';
  static const String distributorUpdatePackageStatus = '/api/distributor_update_package_status';
  static const String distributorResetPackageCommission = '/api/distributor_reset_package_commission';
  static const String distributorBulkPackageOptions = '/api/distributor_bulk_package_options';
  static const String distributorBulkPackageCharge = '/api/distributor_bulk_package_charge';
  static const String distributorBulkPackageChange = '/api/distributor_bulk_package_change';
  static const String distributorGrade = '/api/distributor_grade';
  static const String distributorGetKyc = '/api/distributor_get_kyc';
  static const String distributorSubmitKyc = '/api/distributor_submit_kyc';
  static const String distributorGetSupport = '/api/distributor_get_support';
  static const String distributorLoginHistory = '/api/distributor_login_history';
  static const String distributorStatementDescriptions = '/api/distributor_statement_descriptions';
  static const String distributorStatement = '/api/distributor_statement';
  static const String distributorStatementDetail = '/api/distributor_statement_detail';
  static const String distributorRegChargeDetail = '/api/distributor_reg_charge_detail';
  static const String distributorOnlineTransactions = '/api/distributor_online_transactions';
}
