import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/recharge/success_recharge_page.dart';

class ConfirmTransactionPage extends StatelessWidget {
  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

  const ConfirmTransactionPage({
    super.key,
    this.productName = 'Jio',
    this.operatorInitial = 'J',
    this.operatorColor = Colors.red,
    this.transactionNo = 'TXN24321232323',
    this.amount = '\u{20B9}365.00',
    this.commission = '\u{20B9}40.00',
    this.surcharge = '\u{20B9}5',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CommonAppBar(title: "Confirm Transaction"),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TransactionSummaryCard(
                productName: productName,
                operatorInitial: operatorInitial,
                operatorColor: operatorColor,
                transactionNo: transactionNo,
                amount: amount,
                commission: commission,
                surcharge: surcharge,
              ),
              SizedBox(height: 18.h),
              _buildInputLabel(context, 'Re-enter Amount'),
              _buildTextField(context, 'Enter amount'),
              SizedBox(height: 220.h),
              Center(
                child: CommonButton(
                  title: 'Pay Now',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessRechargePage(
                          productName: productName,
                          operatorInitial: operatorInitial,
                          operatorColor: operatorColor,
                          rechargeAmount: amount,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String hint, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 14.sp, color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? AppColors.textclr : Colors.grey,
          fontSize: 13.sp,
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkplceholder : Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide(color: AppColors.clrPrimary),
        ),
      ),
    );
  }
}

class _TransactionSummaryCard extends StatelessWidget {
  const _TransactionSummaryCard({
    required this.productName,
    required this.operatorInitial,
    required this.operatorColor,
    required this.transactionNo,
    required this.amount,
    required this.commission,
    required this.surcharge,
  });

  final String productName;
  final String operatorInitial;
  final Color operatorColor;
  final String transactionNo;
  final String amount;
  final String commission;
  final String surcharge;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : const Color(0xFFF6F7FF),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            context,
            label: 'Product Name',
            value: productName,
            trailing: _OperatorBadge(
              label: productName.isNotEmpty ? productName : operatorInitial,
              color: operatorColor,
            ),
          ),
          SizedBox(height: 18.h),
          _buildDetailRow(
            context,
            label: 'Payment Status',
            value: 'Received',
            valueColor: const Color(0xFF00B050),
          ),
          SizedBox(height: 18.h),
          _buildDetailRow(
            context,
            label: 'Transaction No',
            value: transactionNo,
            compactValue: true,
          ),
          SizedBox(height: 12.h),
          _AmountBand(
            label: 'Available Balance',
            value: '\u{20B9}76954.70',
            color: const Color(0xFF315CFF),
            backgroundColor: const Color(0xFFE1E6FF),
          ),
          SizedBox(height: 10.h),
          _AmountBand(
            label: 'Transaction Amount',
            value: amount,
            color: const Color(0xFFFF003D),
            backgroundColor: const Color(0xFFFFDFE2),
          ),
          SizedBox(height: 10.h),
          _AmountBand(
            label: 'Commission',
            value: commission,
            color: const Color(0xFF00B050),
            backgroundColor: const Color(0xFFDFF8E9),
          ),
          SizedBox(height: 10.h),
          // _AmountBand(
          //   label: 'Surcharge',
          //   value: surcharge,
          //   color: const Color(0xFFFF4F6D),
          //   backgroundColor: const Color(0xFFFFE2E7),
          // ),
          // SizedBox(height: 10.h),
          _AmountBand(
            label: 'Remaining Balance',
            value: '\u{20B9}76954.70',
            color: const Color(0xFF315CFF),
            backgroundColor: const Color(0xFFE1E6FF),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    Widget? trailing,
    bool compactValue = false,
  }) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing ??
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: compactValue ? 12.sp : 13.sp,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? textColor,
                ),
              ),
            ),
      ],
    );
  }
}

class _OperatorBadge extends StatelessWidget {
  const _OperatorBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: color,
      child: Text(
        label.length <= 3 ? label : label.substring(0, 3),
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class _AmountBand extends StatelessWidget {
  const _AmountBand({
    required this.label,
    required this.value,
    required this.color,
    required this.backgroundColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
