import 'package:get_it/get_it.dart';
import 'package:maxpay/controller/wallet_controller.dart';
import 'package:maxpay/core/service/api_service.dart';
import 'package:maxpay/core/service/local_storage_service.dart';
import 'package:maxpay/data/repository/wallet_credit_type_repository_impl.dart';
import 'package:maxpay/domain/repository/wallet_credit_type_repository.dart';
import 'package:maxpay/domain/usecase/wallet_credit_type_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await LocalStorageService().init();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerSingleton<SharedPreferences>(prefs);
  }
  // Core services
  if (!sl.isRegistered<ApiService>()) {
    sl.registerLazySingleton(() => ApiService());
  }

  // // Repositories
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()));
  

  // // UseCases
  sl.registerLazySingleton<GetWalletCreditTypeUseCase>(() => GetWalletCreditTypeUseCase(sl()));
  
  //controllers

  sl.registerFactory<WalletController >(
        () => WalletController(
      getWalletCreditTypeUseCase: sl(),
    ),
  );
  
}
