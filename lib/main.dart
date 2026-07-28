import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/view/nav_page/navbar_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxpay/controller/app_lifecycle_controller.dart';
import 'core/bindings/initial_binding.dart';
import 'core/constants/routes_path.dart';

import 'core/di/service_locator.dart' as di;
import 'core/router/app_router.dart';
import 'core/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  await LocalStorageService().init();
  // Initialize GetX Controllers
  Get.put(ThemeController(sharedPreferences));
  Get.put(NavbarController());
  Get.put(AppLifecycleController());

  // Restrict to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Pay Link Distributor',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          initialBinding: InitialBinding(),

          themeMode: themeController.themeMode,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: SafeArea(top: false, child: child!),
            );
          },
        );
      },
    );
  }
}
