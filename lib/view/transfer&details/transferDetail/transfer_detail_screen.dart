import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_card.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_filter_widget.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_header_card.dart';

class TransferDetailScreen extends StatefulWidget {
  const TransferDetailScreen({super.key});

  @override
  State<TransferDetailScreen> createState() =>
      _TransferDetailScreenState();
}

class _TransferDetailScreenState
    extends State<TransferDetailScreen> {
  String selectedTransactionType = "Transfer";
  bool isReverse = false;

  void _showReverseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Do you want to Reverse the amount ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "₹ 500.00",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                title: "Submit",
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    selectedTransactionType = "Reverse";
                    isReverse = true;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(
        title: "Transfer Detail",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              /// Filter
              TransferDetailFilterWidget(
                selectedType: selectedTransactionType,
                onChanged: (value) {
                  if (value == "Reverse") {
                    _showReverseDialog();
                  } else {
                    setState(() {
                      selectedTransactionType = "Transfer";
                      isReverse = false;
                    });
                  }
                },
              ),

              SizedBox(height: 16.h),

              /// Header Card
              TransferDetailHeaderCard(
                title: isReverse
                    ? "Wallet Reverse"
                    : "Wallet Transfer",
                amount: "₹ 2405.23",
                isReverse: isReverse,
              ),

              SizedBox(height: 16.h),

              /// List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return TransferDetailCard(
                      transactionId: "TXN6453564",
                      dateTime: "2026-11-29 14:38:43",
                      transactionType: isReverse
                          ? "Reverse"
                          : "Transfer",
                      userType: "Retailer",
                      userName: "John",
                      regMobNo: "9087654321",
                      amount: "₹ 500.00",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}