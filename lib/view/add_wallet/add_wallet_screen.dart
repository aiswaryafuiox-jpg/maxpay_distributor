import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/add_wallet_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/extensions/currency.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import '../../global_widget/commom_button.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final AddWalletController _controller = Get.put(sl<AddWalletController>());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController utrController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController receiptController = TextEditingController();

  String? paymentType;

  final List<String> paymentTypes = [
    "IMPS",
    "Bank Transfer",
    "Cash Deposit",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      appBar: const CommonAppBar(title: "Add Wallet", showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Due Amount Card
            Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Due Amount",
                      style: TextHelper.max16.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    _controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _controller.walletBalance.value.currencyIndian,
                            style: TextHelper.lato12.copyWith(fontSize: 18),
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _label("Amount"),
            _textField(amountController, "Enter Amount"),

            const SizedBox(height: 15),

            _label("Payment Type"),
            DropdownButtonFormField<String>(
              initialValue: paymentType,
              decoration: _decoration("Select"),
              dropdownColor: isDark ? const Color(0xff2F3349) : Colors.white,
              items: paymentTypes.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextHelper.max2.copyWith(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  paymentType = value;
                });
              },
            ),

            const SizedBox(height: 15),

            _label("Bank Name"),
            _textField(bankController, "Enter Bank Name"),

            const SizedBox(height: 15),

            _label("UTR No"),
            _textField(utrController, "Enter UTR No"),

            const SizedBox(height: 15),

            _label("Description"),
            _textField(descriptionController, "Write Here", maxLines: 3),
            const SizedBox(height: 15),
            _label("Receipt"),
            _textField(receiptController, "Enter"),
            const SizedBox(height: 30),
            SizedBox(
              width: 170,
              child: CommonButton(title: "Submit", onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: TextHelper.max2),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: _decoration(hint),
    );
  }

  InputDecoration _decoration(String hint) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextHelper.max2.copyWith(color: Colors.grey),
      filled: true,
      fillColor: isDark ? const Color(0xff2F3349) : const Color(0xffF7F8FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
