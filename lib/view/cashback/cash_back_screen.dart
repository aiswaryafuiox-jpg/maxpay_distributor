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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 10.0, top: 4.0),
              child: Text(
                "Product",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.textclr
                      : Colors.black87,
                ),
              ),
            ),

            /// 🔵 Modern Filter Dropdown
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.white
                    : AppColors.darkplceholder,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.darkFilterBorder
                      : Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Obx(() {
                return DropdownButtonFormField<String>(
                  initialValue: controller.selectedProductTypeId.value.isEmpty
                      ? null
                      : controller.selectedProductTypeId.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
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
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textclr
                          : AppColors.clrTextgrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.textclr
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  items: controller.productTypes.map((productType) {
                    return DropdownMenuItem<String>(
                      value: productType.id?.toString() ?? "",
                      child: Text(
                        productType.name ?? "Unknown",
                        style: TextHelper.max1.copyWith(
                          color: theme.brightness == Brightness.dark
                              ? AppColors.textclr
                              : AppColors.darktextclr,
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
                        color: theme.brightness == Brightness.dark
                            ? AppColors.textclr
                            : AppColors.clrTextgrey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.cashBackList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.cashBackList[index];

                    final cashbackText = item.cashbackDisplay ?? "0%";
                    final isNegative = item.isNegative == 1;
                    final cashbackColor = isNegative
                        ? const Color(0xFFFF0000)
                        : const Color(0xFF00C261);

                    return CashbackTile(
                      cashback: cashbackText,
                      cashbackColor: cashbackColor,
                      productName: item.productName ?? "Unknown",
                      productLogo: item.productLogo ?? "",
                      commissionType: item.commissionType ?? "",
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
  final String commissionType;

  const CashbackTile({
    super.key,
    required this.cashback,
    required this.cashbackColor,
    required this.productName,
    required this.productLogo,
    required this.commissionType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: !isDark ? const Color(0xFFF7F8FC) : AppColors.darkplceholder,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Product Logo
          SizedBox(
            width: 38,
            height: 38,
            child: productLogo.isNotEmpty
                ? Image.network(
                    productLogo,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, color: Colors.grey),
                  )
                : CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    child: Text(
                      productName.isNotEmpty ? productName[0] : "?",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),

          const SizedBox(width: 16),

          /// Name
          Expanded(
            child: Text(
              productName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),

          /// Cashback Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                commissionType,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : const Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cashback,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: cashbackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
