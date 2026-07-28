import 'package:get_it/get_it.dart';
import '../../data/repository/login_sendOtp_repo_impl.dart';
import '../../domain/repository/login_sendOtp_repo.dart';
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
import '../../data/repository/retailer_repo_impl.dart';
import '../../domain/usecase/retailer/get_retailers_usecase.dart';
import '../../domain/usecase/retailer/get_retailer_detail_usecase.dart';
import '../../domain/usecase/retailer/get_commission_packages_usecase.dart';
import '../../domain/usecase/retailer/create_retailer_usecase.dart';
import '../../domain/usecase/retailer/update_retailer_usecase.dart';
import '../../domain/usecase/retailer/get_add_wallet_details_usecase.dart';
import '../../domain/usecase/retailer/add_wallet_usecase.dart';
import '../services/api_service.dart';

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
}
