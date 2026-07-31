import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';

class ResendTimerWidget extends StatefulWidget {
  final VoidCallback onResend;

  const ResendTimerWidget({super.key, required this.onResend});

  @override
  State<ResendTimerWidget> createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends State<ResendTimerWidget> {
  Timer? _timer;
  int _start = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (!mounted) return;
    setState(() {
      _start = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    if (_canResend) {
      return GestureDetector(
        onTap: () {
          widget.onResend();
          _startTimer();
        },
        child: Text(
          'Resend code',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 16.sp : 14.sp,
            color: AppColors.clrPrimary, // primary color indicating active state
          ),
        ),
      );
    }

    return Text(
      'Resend code in 00:${_start.toString().padLeft(2, '0')}',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: isTablet ? 16.sp : 14.sp,
        color: AppColors.fav2, // grey color indicating disabled state
      ),
    );
  }
}
