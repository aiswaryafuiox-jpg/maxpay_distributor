
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/controller/payout_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/image_loader.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/data/model/payout/payout_model.dart';

class PayoutDetailsScreen extends StatelessWidget {
  const PayoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<PayoutController>(
      init: sl<PayoutController>(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: const CommonAppBar(title: "Payout Details"),
          body: SafeArea(
            child: Column(
              children: [
                // Date filters and mobile search
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F4FC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _DateField(
                              controller: controller.fromDateController,
                              onTap: () => _pickDate(
                                context,
                                controller.fromDateController,
                                (value) {
                                  controller.updateDateRange(
                                    value,
                                    controller.toDate.value,
                                  );
                                },
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColors.clrPrimary,
                              size: 24,
                            ),
                          ),
                          Expanded(
                            child: _DateField(
                              controller: controller.toDateController,
                              onTap: () => _pickDate(
                                context,
                                controller.toDateController,
                                (value) {
                                  controller.updateDateRange(
                                    controller.fromDate.value,
                                    value,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      TextField(
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        onChanged: controller.searchByMobile,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade500,
                            size: 26,
                          ),
                          suffixIcon:
                              controller.mobileController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        controller.mobileController.clear();
                                        controller.searchByMobile('');
                                      },
                                      icon: const Icon(Icons.close),
                                    )
                                  : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: Color(0xFFD4D4D4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                              color: AppColors.clrPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE0E0E0),
                  ),
                ),

                const SizedBox(height: 18),

                // Total earnings
                Obx(
                  () => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    decoration: BoxDecoration(
                      color: AppColors.clrPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Total Earnings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹ ${controller.totalEarnings.value}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Payout list
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.clrPrimary,
                        ),
                      );
                    }

                    final items = controller.filteredPayoutList;

                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          "No records found",
                          style: TextStyle(
                            color: AppColors.clrTextgrey,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _PayoutCard(item: items[index]);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController textCtrl,
    void Function(String) onPicked,
  ) async {
    final initial = DateTime.tryParse(textCtrl.text) ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.clrPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      textCtrl.text = formatted;
      onPicked(formatted);
    }
  }
}

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateField({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF606060),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: Color(0xFFD2D2D2),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: AppColors.clrPrimary,
          ),
        ),
      ),
    );
  }
}

class _PayoutCard extends StatelessWidget {
  final PayoutItem item;

  const _PayoutCard({
    required this.item,
  });

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '-';

    try {
      final parsed = DateTime.parse(value);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsed);
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),
        borderRadius: BorderRadius.circular(12),
        border: theme.brightness == Brightness.dark
            ? Border.all(color: const Color(0xFF3C3F52))
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  _formatDate(item.dateTime),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Divider(
            color: theme.brightness == Brightness.light
                ? Colors.black12
                : Colors.white24,
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.background,
                child: ClipOval(
                  child: item.productLogo != null &&
                          item.productLogo!.isNotEmpty
                      ? NetworkImageWithLoader(
                          item.productLogo,
                          fit: BoxFit.contain,
                          radius: 20,
                        )
                      : const Icon(
                          Icons.image,
                          size: 20,
                          color: Colors.grey,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productType ?? item.productName ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Amount: ₹${item.transactionAmount ?? "0"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      item.mobileNumber ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Text(
                "₹ ${item.myEarnings ?? "0"}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
