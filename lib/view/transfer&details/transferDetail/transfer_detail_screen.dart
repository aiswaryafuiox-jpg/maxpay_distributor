import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/transfer_detail_controller.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/repository/transfer_detail_repo_impl.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';
import 'package:maxpay/domain/usecase/get_transfer_detail_list_usecase.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_card.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_filter_widget.dart';
import 'package:maxpay/view/transfer&details/transferDetail/widgets/transfer_detail_header_card.dart';

class TransferDetailScreen extends StatefulWidget {
  const TransferDetailScreen({super.key});

  @override
  State<TransferDetailScreen> createState() => _TransferDetailScreenState();
}

class _TransferDetailScreenState extends State<TransferDetailScreen> {
  final controller = Get.put(
    TransferDetailController(
      GetTransferDetailsUseCase(TransferDetailRepositoryImpl(ApiService())),
      GetTransferDetailListUseCase(TransferDetailRepositoryImpl(ApiService())),
    ),
  );
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
      appBar: const CommonAppBar(title: "Transfer Detail"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              /// Filter
              Obx(
                () => TransferDetailFilterWidget(
                  transferTypes: controller.transferDetails
                      .map((e) => e.name ?? "")
                      .toList(),
                  selectedType: controller.selectedTransactionType.value,
                  onChanged: (value) {
                    controller.changeTransactionType(value);
                  },
                ),
              ),

              SizedBox(height: 16.h),

              /// Header Card
              Obx(() => TransferDetailHeaderCard(
                title: isReverse ? "Wallet Reverse" : "Wallet Transfer",
                amount: controller.totalAmount.value,
                isReverse: isReverse,
              )),

              SizedBox(height: 16.h),

              /// List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.transferDetailList.isEmpty) {
                    return const Center(child: Text("No transactions found"));
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.transferDetailList.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = controller.transferDetailList[index];
                      return TransferDetailCard(
                        transactionId: item.transactionId ?? "",
                        dateTime: item.dateTime ?? "",
                        transactionType: item.transactionType ?? "",
                        userType: item.userType ?? "",
                        userName: item.userName ?? "",
                        regMobNo: item.regMobileNumber ?? "",
                        amount: "₹ ${item.amount ?? '0.00'}",
                        onReverseIconTap: () {
                          _showReverseDialog();
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
