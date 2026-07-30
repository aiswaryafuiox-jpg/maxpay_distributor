import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maxpay/controller/login_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';

import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/global_widget/commom_button.dart';

class BiometricsScanningPage extends StatefulWidget {
  const BiometricsScanningPage({super.key});

  @override
  State<BiometricsScanningPage> createState() => _BiometricsScanningPageState();
}

class _BiometricsScanningPageState extends State<BiometricsScanningPage> {
  final LocalAuthentication auth = LocalAuthentication();

  /// GETX CONTROLLER
  final LoginController controller = Get.find<LoginController>();

  bool isAuthenticating = false;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      authenticate();
    });
  }

  Future<void> authenticate() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;

      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        Get.snackbar(
          "Not Supported",
          "Fingerprint is not available on this device",
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      setState(() {
        isAuthenticating = true;
      });

      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to continue',

        biometricOnly: true,

        persistAcrossBackgrounding: true,
      );

      setState(() {
        isAuthenticating = false;
        isAuthenticated = authenticated;
      });

      /// SEND STATUS TO BACKEND
      await controller.toggleFingerprint(authenticated);

      if (authenticated) {
        CustomToast.success("Fingerprint verified successfully");

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(
            AppRoutes.successScreen,
            arguments: {
              "title": "FingerPrint Added Successfully",
              "message": "Your fingerprint has been added successfully",
            },
          );
        });
      } else {
        Get.snackbar(
          "Failed",
          "Fingerprint authentication failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on PlatformException {
      setState(() {
        isAuthenticating = false;
      });

      // Get.snackbar(
      //   "Error",
      //   e.message ?? "Platform Error",
      //   snackPosition:
      //       SnackPosition.BOTTOM,
      // );
    } catch (e) {
      setState(() {
        isAuthenticating = false;
      });

      // Get.snackbar(
      //   "Error",
      //   e.toString(),
      //   snackPosition:
      //       SnackPosition.BOTTOM,
      // );
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();

    setState(() {
      isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,

        elevation: 0,

        leading: IconButton(
          onPressed: () {
            cancelAuthentication();
            Get.back();
          },

          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),

        child: Column(
          children: [
            SizedBox(height: 40.h),

            /// TITLE
            Text(
              'Place Your Finger',

              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 12.h),

            /// SUBTITLE
            Text(
              'Put your finger on the sensor and lift after you feel a vibration',

              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            SizedBox(height: 80.h),

            /// FINGERPRINT ICON
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),

              child: Icon(
                isAuthenticated ? Icons.verified_rounded : Icons.fingerprint,

                size: 150.r,

                color: isAuthenticated ? Colors.green : AppColors.activeBtn,
              ),
            ),

            SizedBox(height: 20.h),

            /// LOADING
            if (isAuthenticating)
              CircularProgressIndicator(color: AppColors.activeBtn),

            const Spacer(),

            /// BUTTONS
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        cancelAuthentication();

                        Get.offAllNamed(AppRoutes.main);
                      },

                      child: Text(
                        'Cancel',

                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20.w),

                  Expanded(
                    child: CommonButton(
                      title: 'Scan Again',

                      onTap: () {
                        authenticate();
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
