import 'package:get_it/get_it.dart';
import '../../data/repository/login_sendOtp_repo_impl.dart';
import '../../domain/repository/login_sendOtp_repo.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../../domain/usecase/create_pin_usecase.dart';
import '../../domain/usecase/verify_pin_usecase.dart';
import '../../domain/usecase/update_fingerprint_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../services/api_service.dart';
final sl = GetIt.instance;
Future<void> init() async {
  /// Api Service
  sl.registerLazySingleton<ApiService>(
        () => ApiService(),
  );
  /// Login Repository
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
      sl<ApiService>(),
    ),
  );
  /// Login UseCase
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
      sl<LoginRepository>(),
    ),
  );
  /// Verify Otp UseCase
  sl.registerLazySingleton<VerifyOtpUseCase>(
        () => VerifyOtpUseCase(
      sl<LoginRepository>(),
    ),
  );
  /// Create Pin UseCase
  sl.registerLazySingleton<CreatePinUseCase>(
        () => CreatePinUseCase(
      sl<LoginRepository>(),
    ),
  );
  /// Verify Pin UseCase
  sl.registerLazySingleton<VerifyPinUseCase>(
        () => VerifyPinUseCase(
      sl<LoginRepository>(),
    ),
  );
  /// Update Fingerprint UseCase
  sl.registerLazySingleton<UpdateFingerprintUseCase>(
        () => UpdateFingerprintUseCase(
      sl<LoginRepository>(),
    ),
  );
  /// Logout UseCase
  sl.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(
      sl<LoginRepository>(),
    ),
  );
}