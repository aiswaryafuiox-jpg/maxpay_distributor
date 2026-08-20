import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class SuportScreen extends StatelessWidget {
  const SuportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> supportList = [
      {"name": "Admin", "phone": "+91 0005451152"},
      {"name": "Sub Admin", "phone": "+91 0005451153"},
    ];

    final darkTheme = Theme.of(context).copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkbgBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkbgBlack,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.clrBg),
      ),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        brightness: Brightness.dark,
        surface: AppColors.darkbgBlack,
        onSurface: AppColors.clrBg,
        onSurfaceVariant: AppColors.textclr,
        outline: AppColors.darkFilterBorder,
      ),
    );

    return Theme(
      data: darkTheme,
      child: Scaffold(
        backgroundColor: AppColors.darkbgBlack,
        appBar: const CommonAppBar(title: "Support"),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: supportList.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = supportList[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkplceholder,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkFilterBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.darkFilterBorder,
                      child: SvgPicture.asset(AssetImages.splashLogo),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.clrBg,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            item["phone"] ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textclr,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Call functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.fav2,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(
                          Icons.call,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "call",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
