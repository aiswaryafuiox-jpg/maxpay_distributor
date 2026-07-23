import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/constants/routes_path.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';
import 'BulkPackageChangeScreen.dart';

class BulkPackageChargeScreen extends StatefulWidget {
  const BulkPackageChargeScreen({super.key});

  @override
  State<BulkPackageChargeScreen> createState() =>
      _BulkPackageChargeScreenState();
}

class _BulkPackageChargeScreenState extends State<BulkPackageChargeScreen> {
  String? package;
  String? userType;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: const CommonAppBar(title: "Bulk Package Charge"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xff2F3349)
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: package,
                    decoration: InputDecoration(
                      hintText: "Select Package",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontFamily: "Poppins",
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color(0xFFD8DFEA), // light border
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color(0xFFD8DFEA),
                          width: 1,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: "Package 1", child: Text("Package 1")),
                      DropdownMenuItem(
                          value: "Package 2", child: Text("Package 2")),
                    ],
                    onChanged: (v) {
                      setState(() {
                        package = v;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: userType,
                    decoration: InputDecoration(
                      hintText: "Select User Type",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontFamily: "Poppins",
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color(0xFFD8DFEA), // light border
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color(0xFFD8DFEA),
                          width: 1,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: "Retailer", child: Text("Retailer")),
                      DropdownMenuItem(
                          value: "Distributor", child: Text("Distributor")),
                    ],
                    onChanged: (v) {
                      setState(() {
                        userType = v;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 120,
                    child: CommonButton(
                      title: "Submit",
                      onTap: () {
                        Get.toNamed(AppRoutes.bulkPackageChange);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //const Divider(),
            Divider(
              color: const Color(0xFFD3D3D3),
              thickness: 1,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}

