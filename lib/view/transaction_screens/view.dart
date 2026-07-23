import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';

class ViewDetailsScreen extends StatelessWidget {
  const ViewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Mock data matching your Figma fields
    final Map<String, String> detailsData = {
      'Product Name': 'Airtel',
      'Payment Status': 'Success',
      'Transaction No': 'TXN9876543210',
      'Available Balance': '₹ 1,250.00',
      'Transaction Amount': '₹ 50.00',
      'Commission': '₹ 2.00',
      'Surcharge': '₹ 0.50',
      'Remaining Balance': '₹ 1,197.50',
      'Request Date & Time': 'May 21, 2026 - 16:12',
      'Response Date & Time': 'May 21, 2026 - 16:13',
    };

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'View Details',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkplceholder
                  : const Color(0xFFF6F7FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? theme.colorScheme.outline
                    : AppColors.totalborde2.withValues(alpha: 0.2),
              ),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: detailsData.length,
              itemBuilder: (context, index) {
                String key = detailsData.keys.elementAt(index);
                String value = detailsData[key]!;

                bool isStatus = key == 'Payment Status';

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          key,
                          style: TextHelper.max1.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 4,
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                          style: TextHelper.max1.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: isStatus && value == 'Success'
                                ? Colors.green
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
