import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimCardWidget extends StatelessWidget {
  const SimCardWidget({
    super.key,
    required this.simLabel,
    required this.simNumber,
    required this.phoneNumber,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  final String simLabel;
  final String simNumber;
  final String phoneNumber;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _SimCardClipper(cutSize: 39.r),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 184.w,
            height: 134.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SimNumberBadge(number: simNumber, color: iconColor),
                    SizedBox(width: 6.w),
                    Text(
                      simLabel,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: iconColor,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 1,
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

class _SimNumberBadge extends StatelessWidget {
  const _SimNumberBadge({required this.number, required this.color});

  final String number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _SimBadgeClipper(cutSize: 5.r),
      child: Container(
        width: 16.w,
        height: 18.h,
        alignment: Alignment.center,
        color: color,
        child: Text(
          number,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _SimBadgeClipper extends CustomClipper<Path> {
  const _SimBadgeClipper({required this.cutSize});

  final double cutSize;

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(cutSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, cutSize)
      ..close();
  }

  @override
  bool shouldReclip(covariant _SimBadgeClipper oldClipper) {
    return oldClipper.cutSize != cutSize;
  }
}

class _SimCardClipper extends CustomClipper<Path> {
  const _SimCardClipper({required this.cutSize});

  final double cutSize;

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(cutSize, size.height)
      ..lineTo(0, size.height - cutSize)
      ..close();
  }

  @override
  bool shouldReclip(covariant _SimCardClipper oldClipper) {
    return oldClipper.cutSize != cutSize;
  }
}
