import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/view/transaction_screens/transaction_success_screen.dart';

class TransactionCard extends StatelessWidget {
  static bool _isDisputeDialogOpen = false;

  final Color bgColor;
  final TransactionStatus status;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const TransactionCard({
    super.key,
    required this.bgColor,
    required this.status,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isSuccess = status == TransactionStatus.success;
    final bool isPending = status == TransactionStatus.pending;
    final bool isFailed = status == TransactionStatus.failed;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction ID: TXN6453564",
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Date & Time:",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    "29-11-2026 07:38:43 PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Jio",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jio",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: theme.brightness == Brightness.dark
                          ? Colors.black
                          : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Number: ******7823",
                      style: TextStyle(
                        fontSize: 11,
                        //color: theme.colorScheme.onSurfaceVariant,
                        color: theme.brightness == Brightness.dark
                            ? Colors.black
                            : theme.colorScheme.onSurface,

                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ 365.00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: theme.brightness == Brightness.dark
                          ? Colors.black
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 1),

                  if (isFailed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customButton(
                            text: "Failed",
                            color: Colors.red,
                            isCompact: false,
                          ),
                          // const SizedBox(width: 4),
                          // customButton(
                          //   text: "View",
                          //   color: AppColors.lightbg,
                          //   isCompact: false,
                          //   onTap: () {
                          //     Get.toNamed(AppRoutes.view);
                          //   },
                          // ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isPending ? Color(0xFFD98200) :Color(0xFF00A954), //AppColors.fav3,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isPending ? "Processing" : "Success",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (isSuccess) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
        //         children: [
        //           customButton(
        //             text: "Fav",
        //             color: isFavorite ? const Color(0xFFFF6D00) : AppColors.fav,
        //             icon: Icons.star_border,
        //             onTap: onFavoriteTap,
        //           ),
        //           customButton(
        //             text: "Dispute",
        //             color: Colors.red,
        //             onTap: () {
        //               _showDisputeDialog(context);
        //             },
        //           ),
        //           customButton(
        //             text: "View",
        //             color: AppColors.lightbg,
        //             onTap: () {
        //               Get.toNamed(AppRoutes.view);
        //             },
        //           ),
        //           customButton(text: "Share", color: AppColors.fav2),
        //         ],
        //       ),
        //     ),
        //   ],
        // ],
      ),
    )]]));
  }

  Widget customButton({
    required String text,
    required Color color,
    IconData? icon,
    VoidCallback? onTap,
    bool isCompact = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 8 : 12,
          vertical: isCompact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: text == "View"
              ? Border.all(color: Colors.blue.withValues(alpha: 0.3))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isCompact ? 10 : 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(icon, color: Colors.white, size: 15),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showDisputeDialog(BuildContext context) async {
    if (_isDisputeDialogOpen || !context.mounted) {
      return;
    }

    _isDisputeDialogOpen = true;

    try {
      await showDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        builder: (_) => const _DisputeDialog(),
      );
    } finally {
      _isDisputeDialogOpen = false;
    }
  }
}

class _DisputeDialog extends StatefulWidget {
  const _DisputeDialog();

  @override
  State<_DisputeDialog> createState() => _DisputeDialogState();
}

class _DisputeDialogState extends State<_DisputeDialog> {
  final TextEditingController _remarksController = TextEditingController();
  String? _selectedIssue;

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Dispute",
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Select Issue",
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.45,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.15),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedIssue,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  hint: Text(
                    "Select Issue",
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                  items:  [
                    DropdownMenuItem(
                      value: "Amount not credited",
                      child: Text("Amount not credited",  style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),),
                    ),
                    DropdownMenuItem(
                      value: "Wrong number",
                      child: Text("Wrong number",  style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),),
                    ),
                    DropdownMenuItem(
                      value: "Recharge failed",
                      child: Text("Recharge failed",  style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),),
                    ),
                     DropdownMenuItem(
                      value: "Other",
                      child: Text("Other",  style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),),
                    ),
                   
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedIssue = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Write here",
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _remarksController,
              minLines: 4,
              maxLines: 5,
              cursorColor: theme.colorScheme.onSurface,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.45,
                ),
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.15),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
