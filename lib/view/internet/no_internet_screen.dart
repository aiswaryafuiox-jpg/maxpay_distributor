import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/services/network_service.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key, this.onRetry});
  final Future<void> Function()? onRetry;

  static const Color kThemeColor = Color(0xff17A2B8);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with TickerProviderStateMixin {
  bool _isChecking = false;
late final AnimationController _waveController;
  late final Animation<double> _waveAnimation;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  late final AnimationController _entranceController;
  late final Animation<double> _entranceFade;
  late final Animation<Offset> _entranceSlide;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _waveAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 0.35,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.35,
          end: -0.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -0.2,
          end: 0.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.2,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
    ]).animate(_waveController);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _entranceFade = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _entranceSlide =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  Future<void> _retryConnection() async {
    setState(() => _isChecking = true);

    if (widget.onRetry != null) {
      await widget.onRetry!();
    } else {
      // Request a fresh check from the NetworkService
      try {
        final networkService = Get.find<NetworkService>();
        await networkService.checkInternetNow();
      } catch (e) {
        debugPrint(e.toString());
      }
      // Add a small delay for the check to process and UI to react
      await Future.delayed(const Duration(milliseconds: 900));
    }

    if (mounted) {
      setState(() => _isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color themeColor = NoInternetScreen.kThemeColor;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FadeTransition(
                opacity: _entranceFade,
                child: SlideTransition(
                  position: _entranceSlide,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ----- Box containing the toy hand + "no signal" badge -----
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: themeColor.withValues(alpha: 0.25),
                            width: 1.4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: themeColor.withValues(alpha: 0.12),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Expanding pulse ring
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                final double scale =
                                    1.0 + (_pulseAnimation.value * 0.5);
                                final double opacity =
                                    (1.0 - _pulseAnimation.value).clamp(
                                      0.0,
                                      1.0,
                                    );
                                return Opacity(
                                  opacity: opacity * 0.35,
                                  child: Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: themeColor.withValues(alpha: 0.15),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: themeColor.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                            ),

                            AnimatedBuilder(
                              animation: _waveAnimation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _waveAnimation.value,
                                  alignment: Alignment.bottomCenter,
                                  child: child,
                                );
                              },
                              child: Icon(
                                Icons.front_hand_rounded,
                                size: 72,
                                color: themeColor,
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: AnimatedBuilder(
                                  animation: _pulseController,
                                  builder: (context, child) {
                                    final double t = _pulseController.value;

                                    final double blink =
                                        (0.55 + 0.45 * (1 - (2 * t - 1).abs()));
                                    return Opacity(
                                      opacity: blink,
                                      child: child,
                                    );
                                  },

                                  child: Icon(
                                    Icons.wifi_off_rounded,
                                    size: 20,
                                    color: themeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'No Internet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // const Text(
                      //   'No internet, please try again.',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.black54,
                      //     height: 1.4,
                      //   ),
                      // ),
                      const SizedBox(height: 32),

                      // ----- Retry button -----
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isChecking ? null : _retryConnection,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            disabledBackgroundColor: themeColor.withValues(
                              alpha: 0.6,
                            ),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: _isChecking
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Try Again',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ), // Column
                ), // SlideTransition
              ), // FadeTransition
            ),
          ),
        ),
      ),
    );
  }
}
