import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/app_lifecycle_controller.dart';
import 'package:maxpay/controller/login_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/sim_util.dart';
import 'package:maxpay/core/utils/snackbar.dart';


class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen>
    with SingleTickerProviderStateMixin {
  static const double _logoSize = 200;
  static const double _sourceLogoSize = 200;

  static const double _payPieceWidth = 150;
  static const double _payPieceLeft = 13.0068;
  static const double _payPieceTop = 49.5764;

  static const double _linkPieceWidth = 200;
  static const double _linkPieceLeft = 34.4898;
  static const double _linkPieceTop = 15.0678;

  late final AnimationController _controller;
  late final Animation<Offset> _leftLogoAnimation;
  late final Animation<Offset> _rightLogoAnimation;
  late final Animation<double> _piecesOpacityAnimation;
  late final Animation<double> _hookTurnAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    final hookAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.62, curve: Curves.easeOutBack),
    );

    final logoAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.62, curve: Curves.easeOutCubic),
    );

    _leftLogoAnimation = Tween<Offset>(
      begin: const Offset(-2.8, -0.15),
      end: Offset.zero,
    ).animate(hookAnimation);

    _rightLogoAnimation = Tween<Offset>(
      begin: const Offset(2.8, 0.05),
      end: Offset.zero,
    ).animate(logoAnimation);

    _hookTurnAnimation = Tween<double>(
      begin: -0.035,
      end: 0,
    ).animate(hookAnimation);

    _piecesOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 80),
    ]).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _checkSession();
      }
    });
  }

  Future<void> _checkSession() async {
    final storage = LocalStorageService();
    await storage.init();

    final token = storage.getString("token");
    final isPin = storage.getInt("is_pin") ?? 0;
    final isFingerPrint = storage.getInt("is_finger_print") ?? 0;
    final loggedInPhone = storage.getString("logged_in_phone");

    AppLogger.logError("TOKEN : $token");
    AppLogger.logError("IS PIN : $isPin");
    AppLogger.logError("IS FINGERPRINT : $isFingerPrint");

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    /// Not Logged In
    if (token == null || token.isEmpty) {
      Get.offAllNamed(AppRoutes.intro);
      return;
    }

    /// Verify SIM Binding
    if (loggedInPhone != null && loggedInPhone.isNotEmpty) {
      final bool isSimValid = await SimUtil.verifySimPresent(loggedInPhone);
      if (!isSimValid) {
        AppLogger.logError(
          "SIM Binding Failed. Calling backend logout API and clearing data.",
        );
        CustomToast.error("The already logged number doesn't exist in device");

        if (Get.isRegistered<LoginController>()) {
          await Get.find<LoginController>().forceLogout();
        } else {
          await storage.clear();
          Get.offAllNamed(AppRoutes.intro);
        }
        return;
      }
    }

    /// Old User -> PIN Created
    if (isPin == 1) {
      final lastActiveStr = storage.getString("last_active_time");
      if (lastActiveStr != null) {
        final lastActive = DateTime.tryParse(lastActiveStr);
        if (lastActive != null) {
          if (!AppLifecycleController.hasCrossedLogoutTime(
            lastActive,
            DateTime.now(),
          )) {
            AppLogger.logError(
              "Cold start: did not cross logout boundaries. Navigating straight to home.",
            );
            Get.offAllNamed(AppRoutes.main);
            return;
          }
        }
      }

      if (isFingerPrint == 1) {
        Get.offAllNamed(AppRoutes.veirfypin);
      } else {
        Get.offAllNamed(AppRoutes.enterPin);
      }
      return;
    }

    /// User Logged In But No PIN
    Get.offAllNamed(AppRoutes.pinCodeCreation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final logoScale = _logoSize.w / _sourceLogoSize;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _piecesOpacityAnimation,
          child: SizedBox(
            width: _logoSize.w,
            height: _logoSize.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: _linkPieceLeft * logoScale,
                  top: _linkPieceTop * logoScale,
                  child: SlideTransition(
                    position: _rightLogoAnimation,
                    child: _SplashLogoImage(
                      asset: AssetImages.edit1,
                      width: _linkPieceWidth * logoScale,
                      isDark: isDark,
                    ),
                  ),
                ),
                Positioned(
                  left: _payPieceLeft * logoScale,
                  top: _payPieceTop * logoScale,
                  child: SlideTransition(
                    position: _leftLogoAnimation,
                    child: RotationTransition(
                      turns: _hookTurnAnimation,
                      child: SvgPicture.asset(
                        AssetImages.edit,
                        width: _payPieceWidth * logoScale,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashLogoImage extends StatelessWidget {
  const _SplashLogoImage({
    required this.asset,
    required this.width,
    required this.isDark,
  });

  final String asset;
  final double width;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final image = SvgPicture.asset(asset, width: width, fit: BoxFit.contain);

    if (!isDark) {
      return image;
    }

    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      child: image,
    );
  }
}
