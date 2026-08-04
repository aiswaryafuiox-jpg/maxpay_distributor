import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/transfer_detail_controller.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/services/api_service.dart';
import 'package:maxpay/data/repository/transfer_detail_repo_impl.dart';
import 'package:maxpay/domain/usecase/transfer_detail_usecase.dart';
import 'package:maxpay/domain/usecase/get_transfer_detail_list_usecase.dart';
import 'package:maxpay/domain/usecase/reverse_wallet_transfer_usecase.dart';
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
      ReverseWalletTransferUseCase(TransferDetailRepositoryImpl(ApiService())),
    ),
  );

  void _showReverseDialog(String transactionId, String amount) {
    showDialog(
      context: context,
      barrierDismissible: true,
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
              Text(
                amount,
                style: const TextStyle(
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
                  controller.reverseWalletTransfer(transactionId);
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
                  transferTypes: [
                    "All",
                    ...controller.transferDetails
                        .map((e) => e.name ?? "")
                        .where((name) => name.isNotEmpty && name.toLowerCase() != "all"),
                  ],
                  selectedType: controller.selectedTransactionType.value,
                  fromDate: controller.fromDate.value,
                  toDate: controller.toDate.value,
                  onFromDateChanged: controller.updateFromDate,
                  onToDateChanged: controller.updateToDate,
                  searchController: controller.searchController,
                  onSearchChanged: controller.onSearchChanged,
                  onChanged: (value) {
                    controller.changeTransactionType(value);
                  },
                ),
              ),

              SizedBox(height: 16.h),

              /// Header Card
              Obx(
                () => TransferDetailHeaderCard(
                  title: controller.label.value.isNotEmpty
                      ? controller.label.value
                      : (controller.isReverse.value
                          ? "Wallet Reverse"
                          : "Wallet Transfer"),
                  amount: controller.totalAmount.value,
                  isReverse: controller.isReverse.value,
                ),
              ),

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
                        dateTime: DateFormat(
                          'dd-MMM-yyyy, hh:mm a',
                        ).format(DateTime.parse(item.dateTime ?? "")),
                        transactionType: item.transactionType ?? "",
                        userType: item.userType ?? "",
                        userName: item.userName ?? "",
                        regMobNo: item.regMobileNumber ?? "",
                        amount:
                            (item.amount?.toString() ?? '0.00').currencyIndian,
                        isReversible: item.isReversible == 1,
                        onReverseIconTap: () {
                          _showReverseDialog(
                            item.id?.toString() ?? "",
                            (item.amount?.toString() ?? '0.00').currencyIndian,
                          );
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
