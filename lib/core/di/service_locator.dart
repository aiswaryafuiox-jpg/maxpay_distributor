import 'package:get_it/get_it.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/repository/auto_transfer_details_repo_impl.dart';
import 'package:maxpay/data/repository/update_auto_transfer_repo_impl.dart';
import 'package:maxpay/data/repository/day_book_repo_impl.dart';
import 'package:maxpay/data/repository/my_earnings_repo_impl.dart';
import 'package:maxpay/data/repository/transaction_repo_impl.dart';
import 'package:maxpay/data/repository/cash_back_repo_impl.dart';

import 'package:maxpay/data/repository/transfer_detail_repo_impl.dart';
import 'package:maxpay/domain/repository/transfer_detail_repository.dart';
import '../../data/repository/login_sendOtp_repo_impl.dart';
import '../../data/repository/profile_repo_impl.dart';
import '../../data/repository/retailer_repo_impl.dart';
import '../../data/repository/wallet_credit_type_repository_impl.dart';

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
import '../../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
import '../../domain/usecase/executive/get_executives_usecase.dart';
import '../../domain/usecase/executive/get_executive_detail_usecase.dart';
import '../../domain/usecase/executive/get_executive_commission_packages_usecase.dart';
import '../../domain/usecase/executive/update_executive_usecase.dart';
import '../../domain/usecase/executive/get_executive_add_wallet_details_usecase.dart';
import '../../domain/usecase/executive/add_executive_wallet_usecase.dart';
import '../../domain/repository/transaction_repository.dart';
import '../../data/repository/transaction_repository_impl.dart';
import '../../domain/usecase/transaction/get_transaction_products_usecase.dart';
import '../../domain/usecase/transaction/get_transaction_report_usecase.dart';

// SharedPreferences

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

  sl.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(sl<LoginRepository>()),
  );

  sl.registerLazySingleton<CreatePinUseCase>(
    () => CreatePinUseCase(sl<LoginRepository>()),
  );

  sl.registerLazySingleton<VerifyPinUseCase>(
    () => VerifyPinUseCase(sl<LoginRepository>()),
  );

  sl.registerLazySingleton<UpdateFingerprintUseCase>(
    () => UpdateFingerprintUseCase(sl<LoginRepository>()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<LoginRepository>()),
  );

  /// Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ApiService>()),
  );

  // Transfer Detail Repository
  sl.registerLazySingleton<TransferDetailRepository>(
    () => TransferDetailRepositoryImpl(sl<ApiService>()),
  );

  // Transaction Repository
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl<ApiService>()),
  );

  /// Executive Repository
  sl.registerLazySingleton<ExecutiveRepository>(
    () => ExecutiveRepositoryImpl(sl<ApiService>()),
  );

  /// Profile UseCases
  sl.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<VerifyUpdateProfileOtpUseCase>(
    () => VerifyUpdateProfileOtpUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<ResendUpdateProfileOtpUseCase>(
    () => ResendUpdateProfileOtpUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<UpdateStatusSendOtpUseCase>(
    () => UpdateStatusSendOtpUseCase(sl<ProfileRepository>()),
  );

  sl.registerLazySingleton<VerifyUpdateStatusOtpUseCase>(
    () => VerifyUpdateStatusOtpUseCase(sl<ProfileRepository>()),
  );

  /// Retailer UseCases
  sl.registerLazySingleton<GetRetailersUseCase>(
    () => GetRetailersUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<GetRetailerDetailUseCase>(
    () => GetRetailerDetailUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<GetCommissionPackagesUseCase>(
    () => GetCommissionPackagesUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<CreateRetailerUseCase>(
    () => CreateRetailerUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<UpdateRetailerUseCase>(
    () => UpdateRetailerUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<GetAddWalletDetailsUseCase>(
    () => GetAddWalletDetailsUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<AddWalletUseCase>(
    () => AddWalletUseCase(sl<RetailerRepository>()),
  );

  sl.registerLazySingleton<GetAutoTransferDetailsUseCase>(
      () => GetAutoTransferDetailsUseCase(sl<AutoTransferDetailsRepository>()));

  sl.registerLazySingleton<UpdateAutoTransferUseCase>(
      () => UpdateAutoTransferUseCase(sl<UpdateAutoTransferRepository>()));

  /// Wallet Credit Type
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<GetWalletCreditTypeUseCase>(
    () => GetWalletCreditTypeUseCase(sl<WalletRepository>()),
  );

  sl.registerLazySingleton<WalletCreditListRepository>(
    () => WalletCreditListRepoImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<GetWalletCreditListUseCase>(
    () => GetWalletCreditListUseCase(sl<WalletCreditListRepository>()),
  );

  sl.registerLazySingleton<WalletController>(
    () => WalletController(
      getWalletCreditTypeUseCase: sl<GetWalletCreditTypeUseCase>(),
      getWalletCreditListUseCase: sl<GetWalletCreditListUseCase>(),
    ),
  );

  sl.registerLazySingleton<GetLowWalletRetailersUseCase>(
    () => GetLowWalletRetailersUseCase(sl<LowWalletRepository>()),
  );

  sl.registerLazySingleton<LowWalletController>(
    () => LowWalletController(sl<GetLowWalletRetailersUseCase>()),
  );

  sl.registerFactory<AutoTransferController>(
    () => AutoTransferController(
      getAutoTransferDetailsUseCase: sl<GetAutoTransferDetailsUseCase>(),
      updateAutoTransferUseCase: sl<UpdateAutoTransferUseCase>(),
    ),
  );

  /// Pending Wallet Requests
  sl.registerLazySingleton<PendingWalletRequestRepository>(
    () => PendingWalletRequestRepoImpl(sl<ApiService>()),
  );

  /// Outstanding
  sl.registerLazySingleton<OutstandingRepository>(
    () => OutstandingRepoImpl(sl<ApiService>()),
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
}
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
    () => GetTransactionProductsUseCase(sl<TransactionRepository>()),
  );

  /// Get Transaction Report UseCase
  sl.registerLazySingleton<GetTransactionReportUseCase>(
    () => GetTransactionReportUseCase(sl<TransactionRepository>()),
  );
}
