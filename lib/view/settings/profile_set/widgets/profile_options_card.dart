import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';

class ProfileOptionsCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileOptionsCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: FlipInX(
            animate: true,
            child: Icon(icon, color: AppColors.clrPrimary, size: 22.sp),
          ),
          title: FlipInX(
            animate: true,
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 15.sp),
            ),
          ),
          trailing: FlipInX(
            animate: true,
            child: const Icon(Icons.arrow_forward_ios, size: 15),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Divider(
            thickness: 1,
            color: AppColors.clrTextgrey.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }
}
