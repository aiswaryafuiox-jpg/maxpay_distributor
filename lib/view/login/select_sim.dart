import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/login/widgets/select_sim_widget.dart';

class SelectSimPage extends StatelessWidget {
  const SelectSimPage({super.key});

  static const _simOneBackground = Color(0xFFDCFAFF);
  static const _simOneIcon = Color(0xFF00BCD4);
  static const _simTwoBackground = Color(0xFFC0FFDF);
  static const _simTwoIcon = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
       appBar: const CommonAppBar(
        title: "Select SIM",
      ),
      body: SafeArea(
        child: Center(
          child: Transform.translate(
            offset: Offset(0, -12.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 500.w : double.infinity,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SimCardWidget(
                    simLabel: 'SIM 1',
                    simNumber: '1',
                    phoneNumber: '+91 98877342',
                    backgroundColor: _simOneBackground,
                    iconColor: _simOneIcon,
                    onTap: _openLoginDetails,
                  ),
                  SizedBox(height: 30.h),
                  SimCardWidget(
                    simLabel: 'SIM 2',
                    simNumber: '2',
                    phoneNumber: '+91 98877342',
                    backgroundColor: _simTwoBackground,
                    iconColor: _simTwoIcon,
                    onTap: _openLoginDetails,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void _openLoginDetails() {
    Get.toNamed(AppRoutes.loginPhoneName);
  }
}
