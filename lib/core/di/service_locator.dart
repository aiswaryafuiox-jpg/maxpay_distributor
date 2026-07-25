import 'package:get_it/get_it.dart';
import '../../data/repository/login_sendOtp_repo_impl.dart';
import '../../domain/repository/login_sendOtp_repo.dart';
import '../../domain/usecase/login_sendOtp_usecase.dart';
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
}