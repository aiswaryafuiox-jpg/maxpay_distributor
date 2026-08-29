import 'package:get_it/get_it.dart';
import 'package:maxpay/controller/auto_transfer_controller.dart';
import 'package:maxpay/controller/cash_back_controller.dart';
import 'package:maxpay/controller/low_wallet_controller.dart';
import 'package:maxpay/controller/outstanding_controller.dart';
import 'package:maxpay/controller/pending_wallet_request_controller.dart';
import 'package:maxpay/controller/bank_controller.dart';
import 'package:maxpay/domain/repository/bank_detail_repository.dart';
import 'package:maxpay/data/repository/bank_detail_repoo_impl.dart';
import 'package:maxpay/domain/usecase/bank_detail_usecase.dart';
import 'package:maxpay/data/repository/home_card_repo_impl.dart';
import 'package:maxpay/data/repository/outstanding_repo_impl.dart';
import 'package:maxpay/data/repository/pending_wallet_request_repo_impl.dart';
import 'package:maxpay/data/repository/today_transaction_repo_impl.dart';
import 'package:maxpay/data/repository/wallet_credit_list_repo_impl.dart';
import 'package:maxpay/domain/repository/home_card_repo.dart';
import 'package:maxpay/domain/repository/outstanding_repo.dart';
import 'package:maxpay/domain/repository/pending_wallet_request_repo.dart';
import 'package:maxpay/domain/repository/today_transaction_repo.dart';
import 'package:maxpay/domain/repository/wallet_credit_list_repo.dart';
import 'package:maxpay/domain/repository/web_login_repo.dart';
import 'package:maxpay/data/repository/web_login_repo_impl.dart';
import 'package:maxpay/domain/usecase/web_login_usecase.dart';
import 'package:maxpay/domain/usecase/web_logout_usecase.dart';
import 'package:maxpay/controller/web_login_controller.dart';
import 'package:maxpay/domain/usecase/get_transfer_detail_list_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_home_card_usecase.dart';
import 'package:maxpay/domain/usecase/home/get_today_transaction_amount_usecase.dart';
import '../../controller/banner_controller.dart';
import '../../controller/graph_controller.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/repository/transaction_repository_impl.dart';
import 'package:maxpay/data/repository/transfer_detail_repo_impl.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';
import 'package:maxpay/data/repository/auto_transfer_details_repo_impl.dart';
import 'package:maxpay/data/repository/update_auto_transfer_repo_impl.dart';
import 'package:maxpay/data/repository/day_book_repo_impl.dart';
import 'package:maxpay/data/repository/my_earnings_repo_impl.dart';
import 'package:maxpay/data/repository/transaction_repo_impl.dart';
import 'package:maxpay/data/repository/cash_back_repo_impl.dart';
import 'package:maxpay/data/repository/commission_settings_repo_impl.dart';
import 'package:maxpay/data/repository/grade_repo_impl.dart';
import 'package:maxpay/domain/repository/grade_repo.dart';
import 'package:maxpay/domain/usecase/cashback/get_cash_back_list_usecase.dart';
import 'package:maxpay/domain/usecase/cashback/get_cash_back_product_types_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/delete_day_book_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_list_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_products_usecase.dart';
import 'package:maxpay/domain/usecase/grade/get_grade_usecase.dart';
import 'package:maxpay/controller/grade_controller.dart';
import 'package:maxpay/domain/usecase/retailer/approve_pending_wallet_request_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_auto_transfer_details_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_low_wallet_retailers_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_outstanding_list_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_pending_wallet_request_detail_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_pending_wallet_requests_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_wallet_credit_list_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_auto_transfer_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_outstanding_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/submit_transaction_dispute_usecase.dart';

import 'package:maxpay/data/repository/kyc_repo_impl.dart';
import 'package:maxpay/domain/repository/kyc_repo.dart';
import 'package:maxpay/domain/usecase/kyc/get_kyc_usecase.dart';
import 'package:maxpay/domain/usecase/kyc/submit_kyc_usecase.dart';
import 'package:maxpay/controller/kyc_controller.dart';

import 'package:maxpay/data/repository/support_repo_impl.dart';
import 'package:maxpay/domain/repository/support_repo.dart';
import 'package:maxpay/domain/usecase/my_earnings/get_my_earnings_usecase.dart';
import 'package:maxpay/domain/usecase/support/get_support_usecase.dart';
import 'package:maxpay/controller/support_controller.dart';

import 'package:maxpay/data/repository/login_history_repo_impl.dart';
import 'package:maxpay/domain/repository/login_history_repo.dart';
import 'package:maxpay/domain/usecase/login_history/get_login_history_usecase.dart';
import 'package:maxpay/controller/login_history_controller.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_success_report_usecase.dart';

import 'package:maxpay/data/repository/statement_repo_impl.dart';
import 'package:maxpay/domain/repository/statement_repo.dart';
import 'package:maxpay/data/repository/reg_charge_repo_impl.dart';
import 'package:maxpay/domain/repository/reg_charge_repo.dart';
import 'package:maxpay/data/repository/online_transaction_repo_impl.dart';
import 'package:maxpay/domain/repository/online_transaction_repo.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_descriptions_usecase.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_detail_usecase.dart';
import 'package:maxpay/domain/usecase/statement/get_statement_list_usecase.dart';
import 'package:maxpay/domain/usecase/report/get_reg_charge_detail_usecase.dart';
import 'package:maxpay/domain/usecase/report/get_online_transactions_usecase.dart';
import 'package:maxpay/controller/statement_controller.dart';
import 'package:maxpay/controller/statement_read_more_controller.dart';
import 'package:maxpay/controller/reg_charge_controller.dart';
import 'package:maxpay/controller/online_transaction_controller.dart';
import 'package:maxpay/controller/search_transaction_controller.dart';

import '../../data/repository/login_send_otp_repo_impl.dart';
import '../../domain/repository/login_send_otp_repo.dart';
import '../../domain/repository/profile_repo.dart';
import '../../domain/repository/retailer_repo.dart';

import '../../domain/repository/low_wallet_repo.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';
import 'package:maxpay/domain/repository/my_earnings_repo.dart';
import 'package:maxpay/domain/repository/transaction_repo.dart';
import 'package:maxpay/domain/repository/cash_back_repo.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';

import 'package:maxpay/domain/repository/auto_transfer_details_repo.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';

import '../../data/repository/low_wallet_repo_impl.dart';

import '../../domain/usecase/wallet_credit_type_usecase.dart';
import '../../domain/repository/wallet_credit_type_repository.dart';
import '../../data/repository/wallet_credit_type_repository_impl.dart';
import '../../domain/usecase/reverse_wallet_transfer_usecase.dart';
import '../../controller/wallet_controller.dart';
import '../../controller/day_book_controller.dart';
import '../../controller/my_earnings_controller.dart';
import '../../controller/transaction_controller.dart';
import '../../controller/commission_settings_controller.dart';

import '../../domain/usecase/login_send_otp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../../domain/usecase/create_pin_usecase.dart';
import '../../domain/usecase/verify_pin_usecase.dart';
import '../../domain/usecase/update_pin_usecase.dart';
import '../../domain/usecase/send_update_mpin_otp_usecase.dart';
import '../../domain/usecase/verify_update_mpin_otp_usecase.dart';
import '../../domain/usecase/update_fingerprint_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../controller/login_controller.dart';
import '../../controller/update_pin_controller.dart';
import '../../domain/usecase/profile/get_profile_usecase.dart';
import '../../domain/usecase/profile/update_profile_usecase.dart';
import '../../domain/usecase/profile/verify_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/resend_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/update_status_send_otp_usecase.dart';
import '../../domain/usecase/profile/verify_update_status_otp_usecase.dart';
import '../../data/repository/profile_repo_impl.dart';
import '../../domain/repository/executive_repo.dart';
import '../../data/repository/retailer_repo_impl.dart';
import '../../data/repository/executive_repo_impl.dart';
import '../../domain/usecase/retailer/get_retailers_usecase.dart';
import '../../domain/usecase/retailer/get_retailer_detail_usecase.dart';
import '../../domain/usecase/retailer/get_commission_packages_usecase.dart';
import '../../domain/usecase/retailer/create_retailer_usecase.dart';
import '../../domain/usecase/retailer/update_retailer_usecase.dart';
import '../../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
import '../../domain/usecase/executive/get_executives_usecase.dart';
import '../../domain/usecase/executive/get_executive_detail_usecase.dart';
import '../../domain/usecase/executive/get_executive_commission_packages_usecase.dart';
import '../../domain/usecase/executive/update_executive_usecase.dart';
import '../../domain/usecase/executive/get_executive_add_wallet_details_usecase.dart';
import '../../domain/usecase/executive/add_executive_wallet_usecase.dart';
import 'package:maxpay/domain/usecase/executive/create_executive_usecase.dart';
import '../../domain/repository/transaction_repository.dart';
import '../../domain/usecase/transaction/get_transaction_products_usecase.dart';
import '../../domain/usecase/transaction/get_transaction_report_usecase.dart';
import '../../domain/usecase/transaction/get_transaction_detail_usecase.dart';
import '../../domain/repository/news_repo.dart';
import '../../data/repository/news_repo_impl.dart';
import '../../domain/usecase/home/get_news_usecase.dart';
import '../../domain/repository/banner_repo.dart';
import '../../data/repository/banner_repo_impl.dart';
import '../../domain/usecase/home/get_banner_usecase.dart';
import '../../domain/usecase/home/get_advertisement_usecase.dart';
import '../../domain/usecase/home/get_faq_usecase.dart';
import '../../domain/usecase/home/get_popup_message_usecase.dart';
import '../../domain/usecase/home/faq_reply_usecase.dart';
import '../../domain/repository/faq_repo.dart';
import '../../data/repository/faq_repo_impl.dart';
import '../../domain/repository/faq_reply_repo.dart';
import '../../data/repository/faq_reply_repo_impl.dart';
import '../../domain/repository/popup_message_repo.dart';
import '../../data/repository/popup_message_repo_impl.dart';
import '../../domain/repository/graph_repo.dart';
import '../../data/repository/graph_repo_impl.dart';
import '../../domain/usecase/home/get_graph_usecase.dart';
import '../../domain/repository/ip_address_repo.dart';
import '../../data/repository/ip_address_repo_impl.dart';
import '../../domain/usecase/ip_address_usecase.dart';
import '../../controller/ip_address_controller.dart';

// SharedPreferences

import 'package:maxpay/domain/usecase/settings/get_commission_settings_usecase.dart';

import 'package:maxpay/domain/usecase/settings/update_package_status_usecase.dart';
import 'package:maxpay/domain/usecase/settings/reset_package_commission_usecase.dart';
import 'package:maxpay/domain/usecase/settings/get_bulk_package_options_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_charge_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_change_usecase.dart';
import 'package:maxpay/controller/app_lifecycle_controller.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/data/repository/add_wallet_balance_repo_impl.dart';
import 'package:maxpay/domain/repository/add_wallet_balance_repo.dart';
import 'package:maxpay/domain/usecase/get_add_wallet_balance_usecase.dart';
import 'package:maxpay/data/repository/create_qr_repo_impl.dart';
import 'package:maxpay/domain/repository/create_qr_repo.dart';
import 'package:maxpay/domain/usecase/create_qr_usecase.dart';
import 'package:maxpay/controller/executive_controller.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/controller/retailer_controller.dart';
import 'package:maxpay/controller/transfer_detail_controller.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';
import 'package:maxpay/controller/privacy_policy_controller.dart';
import 'package:maxpay/data/repository/privacy_policy_repo_impl.dart';
import 'package:maxpay/domain/repository/privacy_policy_repo.dart';
import 'package:maxpay/domain/usecase/get_privacy_policy_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  /// Api Service
  sl.registerLazySingleton<ApiService>(() => ApiService());

  /// Home Card
  sl.registerLazySingleton<HomeCardRepository>(
    () => HomeCardRepositoryImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<GetHomeCardUseCase>(
    () => GetHomeCardUseCase(sl<HomeCardRepository>()),
  );

  /// Today Transaction
  sl.registerLazySingleton<TodayTransactionRepository>(
    () => TodayTransactionRepositoryImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<GetTodayTransactionAmountUseCase>(
    () => GetTodayTransactionAmountUseCase(sl<TodayTransactionRepository>()),
  );

  /// Login Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl<ApiService>()),
  );

  /// Login UseCase
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<LoginRepository>()),
  );

  /// Verify Otp UseCase
  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<LoginRepository>()),
  );

  /// Create Pin UseCase
  sl.registerLazySingleton<CreatePinUseCase>(
    () => CreatePinUseCase(sl<LoginRepository>()),
  );

  /// Verify Pin UseCase
  sl.registerLazySingleton<VerifyPinUseCase>(
    () => VerifyPinUseCase(sl<LoginRepository>()),
  );

  /// Update Fingerprint UseCase
  sl.registerLazySingleton<UpdateFingerprintUseCase>(
    () => UpdateFingerprintUseCase(sl<LoginRepository>()),
  );

  /// Logout UseCase
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<LoginRepository>()),
  );

  /// Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ApiService>()),
  );

  /// Retailer Repository
  sl.registerLazySingleton<RetailerRepository>(
    () => RetailerRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));

  sl.registerLazySingleton<BannerRepository>(() => BannerRepositoryImpl(sl()));

  sl.registerLazySingleton<GraphRepository>(() => GraphRepositoryImpl(sl()));

  /// 🔹 USE CASESTransfer Detail Repository
  sl.registerLazySingleton<TransferDetailRepository>(
    () => TransferDetailRepositoryImpl(sl<ApiService>()),
  );

  /// Executive Repository
  sl.registerLazySingleton<ExecutiveRepository>(
    () => ExecutiveRepositoryImpl(sl<ApiService>()),
  );

  /// Get Profile UseCase
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl<ProfileRepository>()),
  );

  /// Update Profile UseCase
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<ProfileRepository>()),
  );

  /// Verify Update Profile OTP UseCase
  sl.registerLazySingleton<VerifyUpdateProfileOtpUseCase>(
    () => VerifyUpdateProfileOtpUseCase(sl<ProfileRepository>()),
  );

  /// Resend Update Profile OTP UseCase
  sl.registerLazySingleton<ResendUpdateProfileOtpUseCase>(
    () => ResendUpdateProfileOtpUseCase(sl<ProfileRepository>()),
  );

  /// Update Status Send OTP UseCase
  sl.registerLazySingleton<UpdateStatusSendOtpUseCase>(
    () => UpdateStatusSendOtpUseCase(sl<ProfileRepository>()),
  );

  /// Verify Update Status OTP UseCase
  sl.registerLazySingleton<VerifyUpdateStatusOtpUseCase>(
    () => VerifyUpdateStatusOtpUseCase(sl<ProfileRepository>()),
  );

  /// Get Retailers UseCase
  sl.registerLazySingleton<GetRetailersUseCase>(
    () => GetRetailersUseCase(sl<RetailerRepository>()),
  );

  /// Get Retailer Detail UseCase
  sl.registerLazySingleton<GetRetailerDetailUseCase>(
    () => GetRetailerDetailUseCase(sl<RetailerRepository>()),
  );

  /// Get Commission Packages UseCase
  sl.registerLazySingleton<GetCommissionPackagesUseCase>(
    () => GetCommissionPackagesUseCase(sl<RetailerRepository>()),
  );

  /// Create Retailer UseCase
  sl.registerLazySingleton<CreateRetailerUseCase>(
    () => CreateRetailerUseCase(sl<RetailerRepository>()),
  );

  /// Update Retailer UseCase
  sl.registerLazySingleton<UpdateRetailerUseCase>(
    () => UpdateRetailerUseCase(sl<RetailerRepository>()),
  );

  /// Get Add Wallet Details UseCase
  sl.registerLazySingleton<GetAddWalletDetailsUseCase>(
    () => GetAddWalletDetailsUseCase(sl<RetailerRepository>()),
  );

  /// Add Wallet UseCase
  sl.registerLazySingleton<AddWalletUseCase>(
    () => AddWalletUseCase(sl<RetailerRepository>()),
  );

  /// Get Executives UseCase
  sl.registerLazySingleton<GetExecutivesUseCase>(
    () => GetExecutivesUseCase(sl<ExecutiveRepository>()),
  );

  /// Get Executive Detail UseCase
  sl.registerLazySingleton<GetExecutiveDetailUseCase>(
    () => GetExecutiveDetailUseCase(sl<ExecutiveRepository>()),
  );

  /// Get Executive Commission Packages UseCase
  sl.registerLazySingleton<GetExecutiveCommissionPackagesUseCase>(
    () => GetExecutiveCommissionPackagesUseCase(sl<ExecutiveRepository>()),
  );

  /// Update Executive UseCase
  sl.registerLazySingleton<UpdateExecutiveUseCase>(
    () => UpdateExecutiveUseCase(sl<ExecutiveRepository>()),
  );

  /// Get Executive Add Wallet Details UseCase
  sl.registerLazySingleton<GetExecutiveAddWalletDetailsUseCase>(
    () => GetExecutiveAddWalletDetailsUseCase(sl<ExecutiveRepository>()),
  );

  /// Add Executive Wallet UseCase
  sl.registerLazySingleton<AddExecutiveWalletUseCase>(
    () => AddExecutiveWalletUseCase(sl<ExecutiveRepository>()),
  );

  /// Get Transaction Products UseCase
  sl.registerLazySingleton<GetTransactionProductsUseCase>(
    () => GetTransactionProductsUseCase(sl<TransactionsListRepository>()),
  );

  /// Get Transaction Report UseCase
  sl.registerLazySingleton<GetTransactionReportUseCase>(
    () => GetTransactionReportUseCase(sl<TransactionsListRepository>()),
  );

  /// Get Transaction Detail UseCase
  sl.registerLazySingleton<GetTransactionDetailUseCase>(
    () => GetTransactionDetailUseCase(sl<TransactionsListRepository>()),
  );
  sl.registerLazySingleton<SubmitTransactionDisputeUseCase>(
    () => SubmitTransactionDisputeUseCase(sl<TransactionsListRepository>()),
  );

  /// Low Wallet
  sl.registerLazySingleton<LowWalletRepository>(
    () => LowWalletRepoImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<AutoTransferDetailsRepository>(
    () => AutoTransferDetailsRepoImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<UpdateAutoTransferRepository>(
    () => UpdateAutoTransferRepoImpl(sl<ApiService>()),
  );

  // Day Book
  sl.registerLazySingleton<DayBookRepository>(() => DayBookRepoImpl(sl()));
  sl.registerLazySingleton<GetDayBookProductsUseCase>(
    () => GetDayBookProductsUseCase(sl()),
  );
  sl.registerLazySingleton<GetDayBookListUseCase>(
    () => GetDayBookListUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteDayBookUseCase>(
    () => DeleteDayBookUseCase(sl()),
  );
  sl.registerFactory(() => DayBookController(sl(), sl(), sl()));

  // My Earnings
  sl.registerLazySingleton<MyEarningsRepository>(
    () => MyEarningsRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetMyEarningsUseCase>(
    () => GetMyEarningsUseCase(sl()),
  );
  sl.registerFactory(() => MyEarningsController(sl()));

  // Transaction Report
  sl.registerLazySingleton<TransactionsListRepository>(
    () => TransactionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetTransactionSuccessReportUseCase>(
    () => GetTransactionSuccessReportUseCase(sl()),
  );
  sl.registerFactory(() => TransactionController(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SearchTransactionController(sl()));

  // CashBack
  sl.registerLazySingleton<CashBackRepository>(() => CashBackRepoImpl(sl()));
  sl.registerLazySingleton<GetCashBackProductTypesUseCase>(
    () => GetCashBackProductTypesUseCase(sl()),
  );
  sl.registerLazySingleton<GetCashBackListUseCase>(
    () => GetCashBackListUseCase(sl()),
  );
  sl.registerFactory(() => CashBackController(sl(), sl()));

  // Commission Settings
  sl.registerLazySingleton<CommissionSettingsRepository>(
    () => CommissionSettingsRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetCommissionSettingsUseCase>(
    () => GetCommissionSettingsUseCase(sl()),
  );
  sl.registerLazySingleton<UpdatePackageStatusUseCase>(
    () => UpdatePackageStatusUseCase(sl()),
  );
  sl.registerLazySingleton<ResetPackageCommissionUseCase>(
    () => ResetPackageCommissionUseCase(sl()),
  );
  sl.registerLazySingleton<GetBulkPackageOptionsUseCase>(
    () => GetBulkPackageOptionsUseCase(sl()),
  );
  sl.registerLazySingleton<BulkPackageChargeUseCase>(
    () => BulkPackageChargeUseCase(sl()),
  );
  sl.registerLazySingleton<BulkPackageChangeUseCase>(
    () => BulkPackageChangeUseCase(sl()),
  );
  sl.registerFactory(
    () => CommissionSettingsController(sl(), sl(), sl(), sl(), sl(), sl()),
  );

  // Grade
  sl.registerLazySingleton<GradeRepository>(() => GradeRepoImpl(sl()));
  sl.registerLazySingleton<GetGradeUseCase>(() => GetGradeUseCase(sl()));
  sl.registerFactory(() => GradeController(sl()));

  // KYC
  sl.registerLazySingleton<KycRepository>(() => KycRepoImpl(sl()));
  sl.registerLazySingleton(() => GetNewsUseCase(sl()));
  sl.registerLazySingleton(() => GetBannerUseCase(sl()));
  sl.registerLazySingleton(() => AdvertisementUsecase(sl()));
  
  sl.registerLazySingleton<FaqRepository>(() => FaqRepoImpl(sl()));
  sl.registerLazySingleton(() => GetFaqUseCase(sl()));
  
  sl.registerLazySingleton<FaqReplyRepository>(() => FaqReplyRepoImpl(sl()));
  sl.registerLazySingleton(() => FaqReplyUseCase(sl()));
  
  sl.registerLazySingleton<PopupMessageRepository>(() => PopupMessageRepoImpl(sl()));
  sl.registerLazySingleton(() => GetPopupMessageUseCase(sl()));
  
  sl.registerLazySingleton(() => GetGraphUseCase(sl()));
  sl.registerLazySingleton<GetKycUseCase>(() => GetKycUseCase(sl()));
  sl.registerLazySingleton<SubmitKycUseCase>(() => SubmitKycUseCase(sl()));
  sl.registerFactory(() => KycController(sl(), sl()));

  // IP Address
  sl.registerLazySingleton<IpAddressRepository>(
    () => IpAddressRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<IpAddressUseCase>(() => IpAddressUseCase(sl()));
  sl.registerFactory(() => IpAddressController(ipAddressUseCase: sl()));

  // Support
  sl.registerLazySingleton<SupportRepository>(() => SupportRepoImpl(sl()));
  sl.registerLazySingleton<GetSupportUseCase>(() => GetSupportUseCase(sl()));
  sl.registerFactory(() => SupportController(sl()));

  // Privacy Policy
  sl.registerLazySingleton<PrivacyPolicyRepository>(
    () => PrivacyPolicyRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetPrivacyPolicyUseCase>(
    () => GetPrivacyPolicyUseCase(sl()),
  );
  sl.registerFactory(() => PrivacyPolicyController(sl()));

  // Login History
  sl.registerLazySingleton<LoginHistoryRepository>(
    () => LoginHistoryRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetLoginHistoryUseCase>(
    () => GetLoginHistoryUseCase(sl()),
  );
  sl.registerFactory(() => LoginHistoryController(sl()));

  // Auto Transfer
  sl.registerLazySingleton<GetAutoTransferDetailsUseCase>(
    () => GetAutoTransferDetailsUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateAutoTransferUseCase>(
    () => UpdateAutoTransferUseCase(sl()),
  );
  sl.registerFactory(
    () => AutoTransferController(
      getAutoTransferDetailsUseCase: sl(),
      updateAutoTransferUseCase: sl(),
    ),
  );

  // Executive
  sl.registerLazySingleton<CreateExecutiveUseCase>(
    () => CreateExecutiveUseCase(sl()),
  );

  sl.registerFactory(
    () => ExecutiveController(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );

  // Home Page
  sl.registerFactory(() => HomePageController(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => BannerController(bannerUsecase: sl(), advusecase: sl()));
  sl.registerFactory(() => GraphController(sl()));

  // Login
  sl.registerLazySingleton<UpdatePinUseCase>(() => UpdatePinUseCase(sl()));
  sl.registerLazySingleton<SendUpdateMpinOtpUseCase>(
    () => SendUpdateMpinOtpUseCase(sl()),
  );
  sl.registerLazySingleton<VerifyUpdateMpinOtpUseCase>(
    () => VerifyUpdateMpinOtpUseCase(sl()),
  );

  sl.registerFactory(
    () => LoginController(
      loginUseCase: sl(),
      verifyOtpUseCase: sl(),
      createPinUseCase: sl(),
      verifyPinUseCase: sl(),
      updateFingerprintUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => UpdatePinController(
      updatePinUseCase: sl(),
      sendUpdateMpinOtpUseCase: sl(),
      verifyUpdateMpinOtpUseCase: sl(),
    ),
  );

  // Low Wallet
  sl.registerLazySingleton<GetLowWalletRetailersUseCase>(
    () => GetLowWalletRetailersUseCase(sl()),
  );
  sl.registerFactory(() => LowWalletController(sl()));

  // Outstanding
  sl.registerLazySingleton<OutstandingRepository>(
    () => OutstandingRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetOutstandingListUseCase>(
    () => GetOutstandingListUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateOutstandingUseCase>(
    () => UpdateOutstandingUseCase(sl()),
  );
  sl.registerFactory(() => OutstandingController(sl(), sl()));

  // Pending Wallet Request
  sl.registerLazySingleton<PendingWalletRequestRepository>(
    () => PendingWalletRequestRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetPendingWalletRequestsUseCase>(
    () => GetPendingWalletRequestsUseCase(sl()),
  );
  sl.registerLazySingleton<GetPendingWalletRequestDetailUseCase>(
    () => GetPendingWalletRequestDetailUseCase(sl()),
  );
  sl.registerLazySingleton<ApprovePendingWalletRequestUseCase>(
    () => ApprovePendingWalletRequestUseCase(sl()),
  );
  sl.registerFactory(() => PendingWalletRequestController(sl(), sl(), sl()));

  // Profile
  sl.registerFactory(
    () => ProfileController(sl(), sl(), sl(), sl(), sl(), sl()),
  );

  // Retailer
  sl.registerFactory(
    () => RetailerController(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );

  // Transfer Detail
  sl.registerLazySingleton<GetTransferDetailsUseCase>(
    () => GetTransferDetailsUseCase(sl()),
  );
  sl.registerLazySingleton<GetTransferDetailListUseCase>(
    () => GetTransferDetailListUseCase(sl()),
  );
  sl.registerLazySingleton<ReverseWalletTransferUseCase>(
    () => ReverseWalletTransferUseCase(sl()),
  );
  sl.registerFactory(() => TransferDetailController(sl(), sl(), sl()));

  // Wallet
  sl.registerLazySingleton<WalletCreditListRepository>(
    () => WalletCreditListRepoImpl(sl()),
  );
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()));
  sl.registerLazySingleton<GetWalletCreditTypeUseCase>(
    () => GetWalletCreditTypeUseCase(sl()),
  );
  sl.registerLazySingleton<GetWalletCreditListUseCase>(
    () => GetWalletCreditListUseCase(sl()),
  );
  sl.registerFactory(
    () => WalletController(
      getWalletCreditTypeUseCase: sl(),
      getWalletCreditListUseCase: sl(),
    ),
  );

  // App Lifecycle
  sl.registerFactory(() => AppLifecycleController());

  // Add Wallet Balance & QR
  sl.registerLazySingleton<AddWalletBalanceRepository>(
    () => AddWalletBalanceRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetAddWalletBalanceUseCase>(
    () => GetAddWalletBalanceUseCase(sl()),
  );

  sl.registerLazySingleton<CreateQrRepository>(() => CreateQrRepoImpl(sl()));
  sl.registerLazySingleton<CreateQrUsecase>(() => CreateQrUsecase(sl()));

  sl.registerFactory(() => AddWalletController(sl(), sl()));

  // Statement
  sl.registerLazySingleton<StatementRepository>(
    () => StatementRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RegChargeRepository>(
    () => RegChargeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<OnlineTransactionRepository>(
    () => OnlineTransactionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetStatementDescriptionsUseCase>(
    () => GetStatementDescriptionsUseCase(sl()),
  );
  sl.registerLazySingleton<GetStatementListUseCase>(
    () => GetStatementListUseCase(sl()),
  );
  sl.registerLazySingleton<GetStatementDetailUseCase>(
    () => GetStatementDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetRegChargeDetailUseCase>(
    () => GetRegChargeDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetOnlineTransactionUseCase>(
    () => GetOnlineTransactionUseCase(sl()),
  );
  sl.registerFactory(() => StatementController(sl(), sl()));
  sl.registerFactory(() => StatementReadMoreController(sl()));
  sl.registerFactory(() => RegChargeController(sl()));
  sl.registerFactory(() => OnlineTransactionController(sl()));

  // Web Login
  // Bank Details
  sl.registerLazySingleton<BankDetailRepository>(
    () => BankDetailRepooImpl(sl()),
  );
  sl.registerLazySingleton<BankDetailUsecase>(
    () => BankDetailUsecase(sl()),
  );
  sl.registerFactory(() => BankDetailController(bankdetailusecase: sl()));
  sl.registerLazySingleton<WebLoginRepository>(
    () => WebLoginRepositoryImpl(apiService: sl()),
  );
  sl.registerLazySingleton<WebLoginUseCase>(() => WebLoginUseCase(sl()));
  sl.registerLazySingleton<WebLogoutUseCase>(() => WebLogoutUseCase(sl()));
  sl.registerFactory(
    () => WebLoginController(webLoginUseCase: sl(), webLogoutUseCase: sl()),
  );
}
