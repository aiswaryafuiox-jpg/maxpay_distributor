import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/controller/executive_controller.dart';
import 'package:maxpay/controller/grade_controller.dart';
import 'package:maxpay/controller/home_controller.dart';
import 'package:maxpay/controller/profile_controller.dart';
import 'package:maxpay/controller/banner_controller.dart';
import 'package:maxpay/controller/graph_controller.dart';
import 'package:maxpay/controller/retailer_controller.dart';
import 'package:maxpay/controller/transaction_controller.dart';
import 'package:maxpay/core/bindings/initial_binding.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/domain/usecase/executive/get_executive_commission_packages_usecase.dart';
import 'package:maxpay/domain/usecase/executive/get_executive_detail_usecase.dart';
import 'package:maxpay/domain/usecase/executive/get_executives_usecase.dart';
import 'package:maxpay/domain/usecase/profile/get_profile_usecase.dart';
import 'package:maxpay/domain/usecase/profile/resend_update_profile_otp_usecase.dart';
import 'package:maxpay/domain/usecase/profile/update_profile_usecase.dart';
import 'package:maxpay/domain/usecase/profile/update_status_send_otp_usecase.dart';
import 'package:maxpay/domain/usecase/profile/verify_update_profile_otp_usecase.dart';
import 'package:maxpay/domain/usecase/profile/verify_update_status_otp_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_products_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_report_usecase.dart';
import 'package:maxpay/domain/usecase/transaction/get_transaction_detail_usecase.dart';
import 'package:maxpay/view/add_wallet/add_wallet_screen.dart';
import 'package:maxpay/view/add_wallet_home/add_wallet_screen.dart';
import 'package:maxpay/view/balance/wallet.dart';
import 'package:maxpay/view/bank_detail/bank_details.dart';
import 'package:maxpay/view/cashback/cash_back_screen.dart';
import 'package:maxpay/view/dth_recharge/dth_recharge_page.dart';
import 'package:maxpay/view/favorite/favorite.dart';
import 'package:maxpay/view/grade/grade_screen.dart';
import 'package:maxpay/view/home/pages/home_page.dart';
import 'package:maxpay/view/home/widgets/services_section.dart';
import 'package:maxpay/view/internet/no_internet_screen.dart';
import 'package:maxpay/view/kyc/kyc_screen.dart';
import 'package:maxpay/view/login/biometrics/biometrics_intro.dart';
import 'package:maxpay/view/login/biometrics/biometrics_scanning.dart';
import 'package:maxpay/view/login/biometrics/pin_code_creation.dart';
import 'package:maxpay/view/login/biometrics/enter_pin_screen.dart';
import 'package:maxpay/view/login/biometrics/success_screen.dart';
import 'package:maxpay/view/login/otp_verification_screen.dart';
import 'package:maxpay/view/login/login_phone_name.dart';
import 'package:maxpay/view/login/select_sim.dart';
import 'package:maxpay/view/login/welcome_page.dart';
import 'package:maxpay/view/login_history/login_history_screen.dart';
import 'package:maxpay/view/mobile_recharge/mobile_recharge_page.dart';
import 'package:maxpay/view/my_earning/my_earning_screen.dart';
import 'package:maxpay/view/nav_page/nav_page.dart';
import 'package:maxpay/view/notifications/notification_screen.dart';
import 'package:maxpay/view/refund/refund_screen.dart';
import 'package:maxpay/view/search/search_screen.dart';
import 'package:maxpay/view/report/payoutrequest/payout_request_screen.dart';
import 'package:maxpay/view/settings/commission_settings/commission_settings_screen.dart';
import 'package:maxpay/view/settings/settings_page.dart';

import 'package:maxpay/view/splash/intro_page.dart';
import 'package:maxpay/view/splash/main_splash.dart';
import 'package:maxpay/view/statement/read_more.dart';
import 'package:maxpay/view/statement/statement.dart';
import 'package:maxpay/view/support/supoort_screen.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';
import 'package:maxpay/view/transaction_screens/view.dart';
import 'package:maxpay/view/transfer&details/executive/exe_add_wallet_screen.dart';
import 'package:maxpay/view/update_pin/update_pin_screen.dart';
import 'package:maxpay/view/update_pin/update_mpin_otp_screen.dart';

import 'package:maxpay/view/wallet-credit/wallet_credit_screen.dart';
import 'package:maxpay/view/web_login/web_login_otp_screen.dart';
import 'package:maxpay/view/web_login/web_login_screen.dart';
import 'package:maxpay/view/web_login/web_login_success_screen.dart';

import '../../view/report/apipayoutdetail/api_payout_detail_screen.dart';
import '../../view/report/onlinetransaction/online_transaction_screen.dart';
import '../../view/report/paymentrequest/payment_request_screen.dart';
import '../../view/report/regChargeCredit/reg_charge_credit_screen.dart';
import 'package:maxpay/view/request/walletrequestpending/wallet_request_pending_screen.dart';
import '../../view/settings/bulkPackage/bulk_package_change_screen.dart';
import '../../view/settings/bulkPackage/bulk_package_charge_screen.dart';
import '../../view/settings/profile_set/profile_screen.dart';
import '../../view/settings/scan/scan_web_login_screen.dart';
import '../../view/transfer&details/autotransfer/autotransferscreen.dart';
import '../../view/transfer&details/daybook/day_book_screen.dart';
import '../../view/transfer&details/executive/create_executive.dart';
import '../../view/transfer&details/executive/ex_viewdetails_screen.dart';
import '../../view/transfer&details/executive/executive_screen.dart';
import '../../view/transfer&details/lowwallet/low_wallet_screen.dart';
import '../../view/transfer&details/outstanding/outstanding_screen.dart';
import '../../view/transfer&details/payoutDetails/payout_detail_screen.dart';
import '../../view/transfer&details/payoutStatus/payout_status_screen.dart';
import '../../view/transfer&details/retailers/retailer_screen.dart';
import '../../view/transfer&details/retailers/addwalletscreen.dart';
import '../../view/transfer&details/retailers/create_retailer.dart';
import '../../view/transfer&details/retailers/viewdetailscreen.dart';
import '../../view/transfer&details/transferDetail/transfer_detail_screen.dart';
import '../di/service_locator.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const MainSplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(
          () => ProfileController(
            sl<GetProfileUseCase>(),
            sl<UpdateProfileUseCase>(),
            sl<VerifyUpdateProfileOtpUseCase>(),
            sl<ResendUpdateProfileOtpUseCase>(),
            sl<UpdateStatusSendOtpUseCase>(),
            sl<VerifyUpdateStatusOtpUseCase>(),
          ),
          fenix: true,
        );
      }),
    ),
    GetPage(name: AppRoutes.intro, page: () => const IntroPage()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.selectSim, page: () => const SelectSimPage()),
    GetPage(
      name: AppRoutes.loginPhoneName,
      page: () => const LoginPhoneNamePage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const ScreenOtpVerification(),
    ),
    GetPage(
      name: AppRoutes.biometricsIntro,
      page: () => const BiometricsIntroPage(),
    ),
    GetPage(
      name: AppRoutes.biometricsScanning,
      page: () => const BiometricsScanningPage(),
    ),
    GetPage(
      name: AppRoutes.pinCodeCreation,
      page: () => const PinCodeCreationPage(),
    ),
    GetPage(name: AppRoutes.enterPin, page: () => const PinCodeEnterPage()),
    GetPage(name: AppRoutes.successScreen, page: () => const SuccessScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomePageScreen()),
    GetPage(
      name: AppRoutes.main,
      page: () => const NavPageScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomePageController>(
          () => HomePageController(sl(), sl(), sl(), sl(), sl(), sl()),
          fenix: true,
        );
        Get.lazyPut<BannerController>(
          () => BannerController(bannerUsecase: sl(), advusecase: sl()),
          fenix: true,
        );
        Get.lazyPut<GraphController>(() => GraphController(sl()), fenix: true);
      }),
    ),
    GetPage(name: AppRoutes.myearning, page: () => const MyEarningsScreen()),
    GetPage(name: AppRoutes.lowWallet, page: () => const LowWalletScreen()),
    GetPage(name: AppRoutes.bank, page: () => BankDetailsPage()),
    //
    GetPage(
      name: AppRoutes.onlineTransaction,
      page: () => const OnlineTransactionScreen(),
    ),
    GetPage(
      name: AppRoutes.payoutDetails,
      page: () => const PayoutDetailScreen(),
    ),

    GetPage(
      name: AppRoutes.payoutRequest,
      page: () => const PayoutRequestScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentRequest,
      page: () => const PaymentRequestScreen(),
    ),

    GetPage(name: AppRoutes.withdrawrequest1, page: () => WalletCreditScreen()),
    GetPage(name: AppRoutes.withdrawrequest2, page: () => WalletCreditScreen()),
    GetPage(
      name: AppRoutes.retailer,
      page: () => const RetailerScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => RetailerController(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
        );
      }),
    ),
    GetPage(
      name: AppRoutes.createRetailerScreen,
      page: () => const CreateRetailerScreen(),
    ),
    GetPage(
      name: AppRoutes.retaddWalletScreen,
      page: () => const RetAddWalletScreen(),
    ),
    GetPage(
      name: AppRoutes.retviewDetailsScreen,
      page: () => const RetViewDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.executive,
      page: () => const ExecutiveScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => ExecutiveController(
            sl<GetExecutivesUseCase>(),
            sl<GetExecutiveDetailUseCase>(),
            sl<GetExecutiveCommissionPackagesUseCase>(),
            sl(),
            sl(),
            sl(),
            sl(),
          ),
        );
      }),
    ),
    GetPage(
      name: AppRoutes.createExecutive,
      page: () => const CreateExecutiveScreen(),
    ),
    GetPage(
      name: AppRoutes.exviewDetails,
      page: () => const ExeViewDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.exeAddWalletScreen,
      page: () => const ExeAddWalletScreen(),
    ),

    GetPage(
      name: AppRoutes.autoTransferScreen,
      page: () => const AutoTransferScreen(),
    ),
    GetPage(
      name: AppRoutes.transferDetail,
      page: () => const TransferDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.payOutDetails,
      page: () => const PayoutDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.payOutStatus,
      page: () => const PayoutStatusScreen(),
    ),

    //commission
    GetPage(
      name: AppRoutes.commission,
      page: () => const CommissionSettingsScreen(),
    ),

    GetPage(name: AppRoutes.refund, page: () => const RefundScreen()),
    GetPage(name: AppRoutes.cashback, page: () => const CashbackScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.support, page: () => const SuportScreen()),
    GetPage(name: AppRoutes.kyc, page: () => const KycScreen()),
    GetPage(
      name: AppRoutes.loginhistory,
      page: () => const LoginHistoryScreen(),
    ),
    GetPage(name: AppRoutes.weblogin, page: () => const WebLoginScreen()),
    GetPage(name: AppRoutes.webotp, page: () => const WebOtpScreen()),
    GetPage(
      name: AppRoutes.websuccess,
      page: () => const WebLoginSuccessScreen(),
    ),
    GetPage(name: AppRoutes.setting, page: () => const SettingsPage()),

    GetPage(
      name: AppRoutes.grade,
      page: () => const GradeScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => GradeController(sl()))),
    ),
    GetPage(name: AppRoutes.prepaid, page: () => const MobileRechargePage()),
    GetPage(name: AppRoutes.menu, page: () => const MenuScreen()),
    GetPage(name: AppRoutes.dth, page: () => const DTHRechargePage()),
    GetPage(
      name: AppRoutes.requestWalletpending,
      page: () => const WalletRequestPendingScreen(),
    ),
    GetPage(
      name: AppRoutes.dueAmountAddwallet,
      page: () => const AddWalletScreen(),
    ),

    GetPage(
      name: AppRoutes.addwallet,
      page: () => const AddWalletScreenMain(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AddWalletController(sl(), sl())),
      ),
    ),
    GetPage(name: AppRoutes.veirfypin, page: () => const PinCodeEnterPage()),
    GetPage(
      name: AppRoutes.transaction,
      page: () {
        final status = Get.arguments as TransactionStatus?;

        return TransactionScreen(status: status ?? TransactionStatus.success);
      },
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => TransactionController(
            sl<GetTransactionProductsUseCase>(),
            sl<GetTransactionReportUseCase>(),
            sl<GetTransactionDetailUseCase>(),
            sl(),
          ),
        );
      }),
    ),
    GetPage(name: AppRoutes.statement, page: () => const StatementScreen()),
    GetPage(
      name: AppRoutes.statementReadMore,
      page: () => StatementReadMoreScreen(),
    ),
    GetPage(name: AppRoutes.outstanding, page: () => const OutstandingScreen()),
    GetPage(name: AppRoutes.dayBook, page: () => const DayBookScreen()),
    GetPage(
      name: AppRoutes.regChargeCredit,
      page: () => const RegChargeCreditScreen(),
    ),
    GetPage(name: AppRoutes.view, page: () => const TransactionDetailsPage()),
    GetPage(name: AppRoutes.favorite, page: () => const FavoriteScreen()),
    GetPage(
      name: AppRoutes.walletBalance,
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AddWalletController(sl(), sl())),
      ),
      page: () => const WalletBalanceScreen(),
    ),
    GetPage(name: AppRoutes.update, page: () => const UpdatePinPage()),
    GetPage(
      name: AppRoutes.updateMpinOtp,
      page: () => const UpdateMpinOtpPage(),
    ),
    //
    GetPage(
      name: AppRoutes.bulkPackageCharge,
      page: () => const BulkPackageChargeScreen(),
    ),
    GetPage(
      name: AppRoutes.scanWebLogin,
      page: () => const ScanWebLoginScreen(),
    ),
    GetPage(
      name: AppRoutes.bulkPackageChange,
      page: () => const BulkPackageChangeScreen(),
    ),
    GetPage(name: AppRoutes.search, page: () => const SearchScreen()),
    GetPage(name: AppRoutes.notification, page: () => NotificationPage()),
    GetPage(name: AppRoutes.noInternet, page: () => const NoInternetScreen()),
  ];
}
