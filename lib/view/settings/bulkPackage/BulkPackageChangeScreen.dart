import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/texthelper.dart';
import '../../../global_widget/commom_button.dart';
import '../../../global_widget/custom_app.dart';

class BulkPackageChangeScreen extends StatefulWidget {
  const BulkPackageChangeScreen({super.key});

  @override
  State<BulkPackageChangeScreen> createState() =>
      _BulkPackageChangeScreenState();
}

class _BulkPackageChangeScreenState
    extends State<BulkPackageChangeScreen> {
  String? package;
  String? status;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      appBar: const CommonAppBar(title: "Bulk Package Change"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _label("No of Retailers"),

            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "30",
                hintStyle: TextHelper.max2,
                filled: true,
                fillColor: isDark
                    ? const Color(0xff2F3349)
                    : const Color(0xffF8F9FA),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.clrPrimary,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            _label("Package"),

            DropdownButtonFormField<String>(
              value: package,
              decoration: InputDecoration(
                hintText: "Select",
                hintStyle: TextHelper.max2,
                filled: true,
                fillColor: isDark
                    ? const Color(0xff2F3349)
                    : const Color(0xffF8F9FA),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.clrPrimary,
                    width: 1.2,
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

            const SizedBox(height: 15),

            _label("Status"),

            DropdownButtonFormField<String>(
              value: status,
              decoration: InputDecoration(
                hintText: "Select",
                hintStyle: TextHelper.max2,
                filled: true,
                fillColor: isDark
                    ? const Color(0xff2F3349)
                    : const Color(0xffF8F9FA),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.clrPrimary,
                    width: 1.2,
                  ),
                ),
              ),
              items: [
                DropdownMenuItem(value: "Active", child: const Text("Active")),
                DropdownMenuItem(value: "Inactive", child: const Text("Inactive")),
              ],
              onChanged: (v) {
                setState(() {
                  status = v;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: 170,
              child: CommonButton(
                title: "Update",
                onTap: () {},
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _label(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: TextHelper.max2,
        ),
      ),
    );
  }
}