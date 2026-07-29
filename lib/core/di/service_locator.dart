import 'package:get_it/get_it.dart';
import 'package:maxpay/core/services/api_service.dart';

import 'package:maxpay/data/repository/auto_transfer_details_repo_impl.dart';
import 'package:maxpay/data/repository/update_auto_transfer_repo_impl.dart';
import 'package:maxpay/data/repository/day_book_repo_impl.dart';
import 'package:maxpay/data/repository/my_earnings_repo_impl.dart';
import 'package:maxpay/data/repository/transaction_repo_impl.dart';
import 'package:maxpay/data/repository/cash_back_repo_impl.dart';
import 'package:maxpay/data/repository/commission_settings_repo_impl.dart';
import 'package:maxpay/data/repository/grade_repo_impl.dart';
import 'package:maxpay/domain/repository/grade_repo.dart';
import 'package:maxpay/domain/usecase/grade/get_grade_usecase.dart';
import 'package:maxpay/controller/grade_controller.dart';

import 'package:maxpay/data/repository/kyc_repo_impl.dart';
import 'package:maxpay/domain/repository/kyc_repo.dart';
import 'package:maxpay/domain/usecase/kyc/get_kyc_usecase.dart';
import 'package:maxpay/domain/usecase/kyc/submit_kyc_usecase.dart';
import 'package:maxpay/controller/kyc_controller.dart';

import 'package:maxpay/data/repository/support_repo_impl.dart';
import 'package:maxpay/domain/repository/support_repo.dart';
import 'package:maxpay/domain/usecase/support/get_support_usecase.dart';
import 'package:maxpay/controller/support_controller.dart';

import 'package:maxpay/data/repository/login_history_repo_impl.dart';
import 'package:maxpay/domain/repository/login_history_repo.dart';
import 'package:maxpay/domain/usecase/login_history/get_login_history_usecase.dart';
import 'package:maxpay/controller/login_history_controller.dart';
import 'package:maxpay/data/repository/transfer_detail_repo_impl.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';
import '../../data/repository/login_sendOtp_repo_impl.dart';
import '../../domain/repository/login_sendOtp_repo.dart';

import '../../domain/repository/profile_repo.dart';
import '../../domain/repository/retailer_repo.dart';
import '../../domain/repository/wallet_credit_type_repository.dart';
import '../../domain/repository/pending_wallet_request_repo.dart';
import '../../domain/repository/outstanding_repo.dart';
import '../../domain/repository/low_wallet_repo.dart';
import '../../domain/repository/wallet_credit_list_repo.dart';
import 'package:maxpay/domain/repository/day_book_repo.dart';
import 'package:maxpay/domain/repository/my_earnings_repo.dart';
import 'package:maxpay/domain/repository/transaction_repo.dart';
import 'package:maxpay/domain/repository/cash_back_repo.dart';
import 'package:maxpay/domain/repository/commission_settings_repo.dart';


import 'package:maxpay/domain/repository/auto_transfer_details_repo.dart';
import 'package:maxpay/domain/repository/update_auto_transfer_repo.dart';

import '../../data/repository/pending_wallet_request_repo_impl.dart';
import '../../data/repository/outstanding_repo_impl.dart';
import '../../data/repository/low_wallet_repo_impl.dart';
import '../../data/repository/wallet_credit_list_repo_impl.dart';

import '../../domain/usecase/wallet_credit_type_usecase.dart';
import '../../domain/usecase/retailer/get_low_wallet_retailers_usecase.dart';
import '../../domain/usecase/retailer/get_wallet_credit_list_usecase.dart';
import '../../controller/wallet_controller.dart';
import '../../controller/low_wallet_controller.dart';
import '../../controller/day_book_controller.dart';
import '../../controller/my_earnings_controller.dart';
import '../../controller/transaction_controller.dart';
import '../../controller/cash_back_controller.dart';
import '../../controller/commission_settings_controller.dart';

import 'package:maxpay/controller/auto_transfer_controller.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../../domain/usecase/create_pin_usecase.dart';
import '../../domain/usecase/verify_pin_usecase.dart';
import '../../domain/usecase/update_fingerprint_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/profile/get_profile_usecase.dart';
import '../../domain/usecase/profile/update_profile_usecase.dart';
import '../../domain/usecase/profile/verify_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/resend_update_profile_otp_usecase.dart';
import '../../domain/usecase/profile/update_status_send_otp_usecase.dart';
import '../../domain/usecase/profile/verify_update_status_otp_usecase.dart';
import '../../domain/repository/profile_repo.dart';
import '../../data/repository/profile_repo_impl.dart';
import '../../domain/repository/retailer_repo.dart';
import '../../domain/repository/executive_repo.dart';
import '../../data/repository/retailer_repo_impl.dart';
import '../../data/repository/executive_repo_impl.dart';
import '../../domain/usecase/retailer/get_retailers_usecase.dart';
import '../../domain/usecase/retailer/get_retailer_detail_usecase.dart';
import '../../domain/usecase/retailer/get_commission_packages_usecase.dart';
import '../../domain/usecase/retailer/create_retailer_usecase.dart';
import '../../domain/usecase/retailer/update_retailer_usecase.dart';

import 'package:maxpay/domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/add_wallet_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/get_auto_transfer_details_usecase.dart';
import 'package:maxpay/domain/usecase/retailer/update_auto_transfer_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_products_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/get_day_book_list_usecase.dart';
import 'package:maxpay/domain/usecase/daybook/delete_day_book_usecase.dart';
import 'package:maxpay/domain/usecase/my_earnings/get_my_earnings_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_success_report_usecase.dart';
import 'package:maxpay/domain/usecase/cashback/get_cash_back_product_types_usecase.dart';
import 'package:maxpay/domain/usecase/cashback/get_cash_back_list_usecase.dart';
import 'package:maxpay/domain/usecase/settings/get_commission_settings_usecase.dart';

import 'package:maxpay/domain/usecase/settings/update_package_status_usecase.dart';
import 'package:maxpay/domain/usecase/settings/reset_package_commission_usecase.dart';
import 'package:maxpay/domain/usecase/settings/get_bulk_package_options_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_charge_usecase.dart';
import 'package:maxpay/domain/usecase/settings/bulk_package_change_usecase.dart';

import '../../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
import '../../domain/usecase/executive/get_executives_usecase.dart';
import '../../domain/usecase/executive/get_executive_detail_usecase.dart';
import '../../domain/usecase/executive/get_executive_commission_packages_usecase.dart';
import '../../domain/usecase/executive/update_executive_usecase.dart';
import '../../domain/usecase/executive/get_executive_add_wallet_details_usecase.dart';
import '../../domain/usecase/executive/add_executive_wallet_usecase.dart';
import '../../domain/repository/transaction_repository.dart';
import '../../domain/usecase/transaction/get_transaction_products_usecase.dart';
import '../../domain/usecase/transaction/get_transaction_report_usecase.dart';
import '../../domain/usecase/transaction/get_transaction_detail_usecase.dart';



final sl = GetIt.instance;
Future<void> init() async {
  /// Api Service
  sl.registerLazySingleton<ApiService>(() => ApiService());

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
    () => RetailerRepositoryImpl(sl<ApiService>()),
  );

  // Transfer Detail Repository
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

  /// Low Wallet
  sl.registerLazySingleton<LowWalletRepository>(
    () => LowWalletRepoImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<AutoTransferDetailsRepository>(
      () => AutoTransferDetailsRepoImpl(sl<ApiService>()));

  sl.registerLazySingleton<UpdateAutoTransferRepository>(
      () => UpdateAutoTransferRepoImpl(sl<ApiService>()));

  // Day Book
  sl.registerLazySingleton<DayBookRepository>(() => DayBookRepoImpl(sl()));
  sl.registerLazySingleton<GetDayBookProductsUseCase>(() => GetDayBookProductsUseCase(sl()));
  sl.registerLazySingleton<GetDayBookListUseCase>(() => GetDayBookListUseCase(sl()));
  sl.registerLazySingleton<DeleteDayBookUseCase>(() => DeleteDayBookUseCase(sl()));
  sl.registerFactory(() => DayBookController(sl(), sl(), sl()));

  // My Earnings
  sl.registerLazySingleton<MyEarningsRepository>(() => MyEarningsRepoImpl(sl()));
  sl.registerLazySingleton<GetMyEarningsUseCase>(() => GetMyEarningsUseCase(sl()));
  sl.registerFactory(() => MyEarningsController(sl()));

  // Transaction Report
  sl.registerLazySingleton<TransactionRepository>(() => TransactionRepoImpl(sl()));
  sl.registerLazySingleton<GetTransactionSuccessReportUseCase>(() => GetTransactionSuccessReportUseCase(sl()));
  sl.registerFactory(() => TransactionController(sl(), sl()));

  // CashBack
  sl.registerLazySingleton<CashBackRepository>(() => CashBackRepoImpl(sl()));
  sl.registerLazySingleton<GetCashBackProductTypesUseCase>(() => GetCashBackProductTypesUseCase(sl()));
  sl.registerLazySingleton<GetCashBackListUseCase>(() => GetCashBackListUseCase(sl()));
  sl.registerFactory(() => CashBackController(sl(), sl()));

  // Commission Settings
  sl.registerLazySingleton<CommissionSettingsRepository>(() => CommissionSettingsRepoImpl(sl()));
  sl.registerLazySingleton<GetCommissionSettingsUseCase>(() => GetCommissionSettingsUseCase(sl()));
  sl.registerLazySingleton<UpdatePackageStatusUseCase>(() => UpdatePackageStatusUseCase(sl()));
  sl.registerLazySingleton<ResetPackageCommissionUseCase>(() => ResetPackageCommissionUseCase(sl()));
  sl.registerLazySingleton<GetBulkPackageOptionsUseCase>(() => GetBulkPackageOptionsUseCase(sl()));
  sl.registerLazySingleton<BulkPackageChargeUseCase>(() => BulkPackageChargeUseCase(sl()));
  sl.registerLazySingleton<BulkPackageChangeUseCase>(() => BulkPackageChangeUseCase(sl()));
  sl.registerFactory(() => CommissionSettingsController(sl(), sl(), sl(), sl(), sl(), sl()));

  // Grade
  sl.registerLazySingleton<GradeRepository>(() => GradeRepoImpl(sl()));
  sl.registerLazySingleton<GetGradeUseCase>(() => GetGradeUseCase(sl()));
  sl.registerFactory(() => GradeController(sl()));

  // KYC
  sl.registerLazySingleton<KycRepository>(() => KycRepoImpl(sl()));
  sl.registerLazySingleton<GetKycUseCase>(() => GetKycUseCase(sl()));
  sl.registerLazySingleton<SubmitKycUseCase>(() => SubmitKycUseCase(sl()));
  sl.registerFactory(() => KycController(sl(), sl()));

  // Support
  sl.registerLazySingleton<SupportRepository>(() => SupportRepoImpl(sl()));
  sl.registerLazySingleton<GetSupportUseCase>(() => GetSupportUseCase(sl()));
  sl.registerFactory(() => SupportController(sl()));

  // Login History
  sl.registerLazySingleton<LoginHistoryRepository>(() => LoginHistoryRepoImpl(sl()));
  sl.registerLazySingleton<GetLoginHistoryUseCase>(() => GetLoginHistoryUseCase(sl()));
  sl.registerFactory(() => LoginHistoryController(sl()));
}


