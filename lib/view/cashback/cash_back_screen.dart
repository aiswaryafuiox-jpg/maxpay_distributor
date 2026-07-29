import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controller/cash_back_controller.dart';

class CashbackScreen extends StatefulWidget {
  const CashbackScreen({super.key});

  @override
  State<CashbackScreen> createState() => _CashbackScreenState();
}

class _CashbackScreenState extends State<CashbackScreen> {
  final CashBackController controller = Get.put(sl<CashBackController>());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light
          ? Colors.white
          : theme.scaffoldBackgroundColor,

      /// ✅ Global AppBar
      appBar: const CommonAppBar(title: "Cash Back"),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

        child: Column(
          children: [
            /// 🔵 Modern Filter Dropdown
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light ? Colors.white : AppColors.darkplceholder,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: theme.brightness == Brightness.dark ? AppColors.darkFilterBorder : Colors.transparent,
                ),
              ),
              child: Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedProductTypeId.value.isEmpty ? null : controller.selectedProductTypeId.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Text(
                    "Select Product Category",
                    style: TextHelper.max1.copyWith(
                      color: theme.brightness == Brightness.dark ? AppColors.textclr : AppColors.clrTextgrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: theme.brightness == Brightness.dark ? AppColors.textclr : theme.colorScheme.onSurfaceVariant,
                  ),
                  items: controller.productTypes.map((productType) {
                    return DropdownMenuItem<String>(
                      value: productType.id?.toString() ?? "",
                      child: Text(
                        productType.name ?? "Unknown",
                        style: TextHelper.max1.copyWith(
                          color: theme.brightness == Brightness.dark ? AppColors.textclr : AppColors.darktextclr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedProductTypeId.value = value;
                      controller.fetchCashBackList();
                    }
                  },
                );
              }),
            ),

            const SizedBox(height: 22),

            /// Cashback List
            Expanded(
              child: Obx(() {
                if (controller.isLoadingList.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.cashBackList.isEmpty) {
                  return Center(
                    child: Text(
                      "Data not found",
                      style: TextHelper.max2.copyWith(
                        color: theme.brightness == Brightness.dark ? AppColors.textclr : AppColors.clrTextgrey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.cashBackList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.cashBackList[index];
                    
                    final cashbackText = item.cashbackDisplay ?? "0%";
                    final isNegative = item.isNegative == 1;
                    final cashbackColor = isNegative ? const Color(0xFFFF0000) : const Color(0xFF00C261);

                    return CashbackTile(
                      cashback: cashbackText,
                      cashbackColor: cashbackColor,
                      productName: item.productName ?? "Unknown",
                      productLogo: item.productLogo ?? "",
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CashbackTile extends StatelessWidget {
  final String cashback;
  final Color cashbackColor;
  final String productName;
  final String productLogo;
  
  const CashbackTile({
    super.key,
    required this.cashback,
    required this.cashbackColor,
    required this.productName,
    required this.productLogo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isNegative = cashbackColor == const Color(0xFFFF0000);
    final Color badgeBgColor = isNegative 
        ? const Color(0xFFFF0000).withValues(alpha: 0.1) 
        : const Color(0xFF00C261).withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: !isDark ? Colors.white : AppColors.darkplceholder,
        borderRadius: BorderRadius.circular(16),
        boxShadow: !isDark ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ] : [],
        border: isDark ? Border.all(color: AppColors.darkFilterBorder) : Border.all(color: Colors.grey.withValues(alpha: 0.05), width: 1),
      ),
      child: Row(
        children: [
          /// Product Logo
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.transparent,
              backgroundImage: productLogo.isNotEmpty ? NetworkImage(productLogo) : null,
              child: productLogo.isEmpty
                  ? Text(
                      productName.isNotEmpty ? productName[0] : "?",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 14),

          /// Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Cashback",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          /// Cashback Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              cashback,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: cashbackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
