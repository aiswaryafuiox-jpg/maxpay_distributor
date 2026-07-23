// import 'package:flutter/material.dart';
// import 'package:maxpay/core/constants/asset_images.dart';
// import 'package:maxpay/core/utils/texthelper.dart';
// import 'package:maxpay/global_widget/commom_button.dart';
// import 'package:maxpay/global_widget/custom_app.dart';
// import 'package:maxpay/view/add_wallet/widge/add_wallet_dialogue.dart';
// import 'package:maxpay/view/add_wallet/widge/add_wallet_widget.dart';
//
// class AddWalletScreen extends StatelessWidget {
//   const AddWalletScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: const CommonAppBar(title: "Add Wallet"),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// QR IMAGE CONTAINER
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     AssetImages.addwallet,
//                     height: 220,
//                     fit: BoxFit.contain,
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// AMOUNT TITLE
//             Text("Amount", style: TextHelper.max9(context)),
//
//             const SizedBox(height: 8),
//
//             TextFormField(
//               keyboardType: TextInputType.number,
//               style: TextStyle(color: colorScheme.onSurface),
//               decoration: InputDecoration(
//                 hintText: "Enter Amount",
//                 hintStyle: TextStyle(
//                   color: theme.colorScheme.onTertiaryFixedVariant,
//                 ),
//                 filled: true,
//                 fillColor: colorScheme.surface,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 14,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: colorScheme.outline),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: colorScheme.primary),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 18),
//
//             /// SUBMIT BUTTON
//             Center(
//               child: CommonButton(
//                 title: "Submit",
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => const AddWalletPopup(),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 28),
//
//             /// RECENT TRANSACTIONS
//             Text("Recent Transactions", style: TextHelper.max10(context)),
//
//             const SizedBox(height: 14),
//
//             transactionCard(
//               context: context,
//               status: "Failed",
//               statusColor: Colors.red,
//               amount: "₹ 500.00",
//             ),
//
//             const SizedBox(height: 12),
//
//             transactionCard(
//               context: context,
//               status: "Success",
//               statusColor: Colors.green,
//               amount: "₹ 500.00",
//             ),
//
//             const SizedBox(height: 12),
//
//             transactionCard(
//               context: context,
//               status: "Processing",
//               statusColor: Colors.orange,
//               amount: "₹ 500.00",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';

import '../../global_widget/commom_button.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
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
      backgroundColor:
      isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: const CommonAppBar(title: "Add Wallet"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Due Amount Card
            Container(
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
                    style: TextHelper.max2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ 245005.23",
                    style: TextHelper.max4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _label("Amount"),
            _textField(amountController, "Enter Amount"),

            const SizedBox(height: 15),

            _label("Payment Type"),
            DropdownButtonFormField<String>(
              value: paymentType,
              decoration: _decoration("Select"),
              dropdownColor:
              isDark ? const Color(0xff2F3349) : Colors.white,
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
              child: CommonButton(
                title: "Submit",
                onTap: () {},
              ),
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
      hintStyle: TextHelper.max2.copyWith(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: isDark
          ? const Color(0xff2F3349)
          : const Color(0xffF7F8FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}