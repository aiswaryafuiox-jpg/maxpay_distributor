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

class _BulkPackageChangeScreenState extends State<BulkPackageChangeScreen> {
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
              decoration: _inputDecoration(
                hint: "30",
                isDark: isDark,
              ),
            ),

            const SizedBox(height: 15),

            _label("Package"),

            _buildDropdown<String>(
              value: package,
              hint: "Select",
              isDark: isDark,
              items: const [
                DropdownMenuItem(
                  value: "Package 1",
                  child: Text("Package 1"),
                ),
                DropdownMenuItem(
                  value: "Package 2",
                  child: Text("Package 2"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  package = value;
                });
              },
            ),

            const SizedBox(height: 15),

            _label("Status"),

            _buildDropdown<String>(
              value: status,
              hint: "Select",
              isDark: isDark,
              items: const [
                DropdownMenuItem(
                  value: "Active",
                  child: Text("Active"),
                ),
                DropdownMenuItem(
                  value: "Inactive",
                  child: Text("Inactive"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  status = value;
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
          style: TextHelper.max4,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required bool isDark,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextHelper.max4,
      filled: true,
      fillColor:
      isDark ? const Color(0xff2F3349) : const Color(0xffF8F9FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
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
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required bool isDark,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: _inputDecoration(
        hint: hint,
        isDark: isDark,
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}