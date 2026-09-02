import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ionicons/flutter_ionicons.dart';
import 'package:get/get.dart';
import 'package:maxpay/controller/bank_controller.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'package:maxpay/core/constants/colors.dart';

import 'package:maxpay/global_widget/custom_app.dart';

import 'package:maxpay/core/di/service_locator.dart';

import 'package:maxpay/data/model/bank_details_model.dart' as model;

const Color kCardBorder = Color(0xFF2F80ED);
const Color kCopyIconColor = Color(0xFF17B7C7);
const Color kBracketColor = Color(0xFFE53935);
const Color kHeaderBlue = Color(0xFF17A2B8);

class BankDetailsPage extends StatelessWidget {
  BankDetailsPage({super.key});

  final BankDetailController controller = Get.put(
    BankDetailController(bankdetailusecase: sl()),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: CommonAppBar(title: "Bank Details"),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bankData = controller.bankData.value;

        if (bankData == null ||
            bankData.data == null ||
            bankData.data!.isEmpty) {
          return const Center(child: Text("No bank details available."));
        }

        final accounts = bankData.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: BankAccountCard(account: accounts[index]),
            );
          },
        );
      }),
    );
  }
}

// ============================================================================
// BANK ACCOUNT CARD
// ============================================================================

class BankAccountCard extends StatelessWidget {
  final model.Data account;

  const BankAccountCard({super.key, required this.account});

  void _copyToClipboard(BuildContext context, String value, String label) {
    Clipboard.setData(ClipboardData(text: value));

    CustomToast.success('Copied');
  }

  // ==========================================================================
  // OPEN QR DIALOG
  // ==========================================================================

  void _openQrDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) {
        return QrPreviewDialog(account: account);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3349) : const Color(0xffF6F8FF),

        border: Border.all(color: AppColors.clrPrimary, width: 1),

        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ================================================================
          // ACCOUNT NAME
          // ================================================================
          Row(
            children: [
              Text(
                "A/C Name : ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              Expanded(
                child: Text(
                  account.accountName ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ================================================================
          // BOTTOM ROW
          // ================================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // ============================================================
              // BANK LOGO
              // ============================================================
              SizedBox(
                width: 60,

                child: Column(
                  children: [
                    Image.network(
                      account.bankLogo ?? "",
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,

                      errorBuilder: (_, _, _) {
                        return Icon(
                          Icons.account_balance,
                          size: 42,
                          color: theme.colorScheme.onSurface,
                        );
                      },
                    ),

                    const SizedBox(height: 3),
                  ],
                ),
              ),

              const SizedBox(width: 1),

              // ============================================================
              // ACCOUNT DETAIL + UPI
              // ============================================================
              Expanded(
                child: Row(
                  children: [
                    // ------------------------------------------------------
                    // ACCOUNT DETAIL
                    // ------------------------------------------------------
                    SizedBox(
                      width: 120,

                      child: Row(
                        children: [
                          Text(
                            "Account Detail",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(width: 4),

                          _CopyIconButton(
                            onTap: () {
                              final String allDetails =
                                  '''
Bank Name: ${account.bankName ?? ''}
Account Type: ${account.accountType ?? ''}
Account Name: ${account.accountName ?? ''}
Account Number: ${account.accountNumber ?? ''}
IFSC Code: ${account.ifscCode ?? ''}
Branch: ${account.branch ?? ''}
UPI ID: ${account.upiId ?? ''}
''';

                              _copyToClipboard(
                                context,
                                allDetails,
                                "Bank Details",
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // ------------------------------------------------------
                    // UPI ID
                    // ------------------------------------------------------
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Text(
                            "UPI ID",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(width: 4),

                          _CopyIconButton(
                            onTap: () {
                              _copyToClipboard(
                                context,
                                account.upiId ?? "",
                                "UPI ID",
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ============================================================
              // SMALL QR
              // CLICK TO OPEN FULL QR
              // ============================================================
              GestureDetector(
                onTap: () {
                  _openQrDialog(context);
                },

                child: BracketedQrBox(
                  data: account.upiId ?? "",
                  boxSize: 60,
                  qrSize: 42,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// COPY ICON
// ============================================================================

class _CopyIconButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CopyIconButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(6),

      child: Padding(
        padding: const EdgeInsets.all(4),

        child: SizedBox(
          width: 14,
          height: 14,
          child: Icon(Ionicons.copy_outline),
        ),
      ),
    );
  }
}

// ============================================================================
// BANK LOGO BADGE
// ============================================================================

class BankLogoBadge extends StatelessWidget {
  final String? logoUrl;
  final String? bankName;

  const BankLogoBadge({super.key, this.logoUrl, this.bankName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 48,
      height: 48,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Container(
            width: 48,
            height: 40,

            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2F3349) : Colors.white,

              borderRadius: BorderRadius.circular(6),

              border: Border.all(
                color: isDark
                    ? const Color(0xFF3C3F52)
                    : const Color(0xFFE0E0E0),
              ),
            ),

            padding: const EdgeInsets.all(6),

            child: (logoUrl != null && logoUrl!.isNotEmpty)
                ? Image.network(
                    logoUrl!,
                    fit: BoxFit.contain,

                    errorBuilder: (_, _, _) {
                      return _fallbackMark();
                    },
                  )
                : _fallbackMark(),
          ),
        ],
      ),
    );
  }

  Widget _fallbackMark() {
    return const Icon(Icons.account_balance, color: kBracketColor, size: 20);
  }
}

// ============================================================================
// QR BOX
// ============================================================================

class BracketedQrBox extends StatelessWidget {
  final String data;
  final double boxSize;
  final double qrSize;
  final double bracketLength;
  final double bracketThickness;

  const BracketedQrBox({
    super.key,
    required this.data,
    required this.boxSize,
    required this.qrSize,
    this.bracketLength = 16,
    this.bracketThickness = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: boxSize,
      height: boxSize,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(8),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),

            blurRadius: 4,

            offset: const Offset(0, 1),
          ),
        ],
      ),

      child: Stack(
        children: [
          Center(
            child: QrImageView(
              data: data,

              version: QrVersions.auto,

              size: qrSize,

              gapless: true,

              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ),

          // TOP LEFT
          Positioned(top: 4, left: 4, child: _corner(topLeft: true)),

          // TOP RIGHT
          Positioned(top: 4, right: 4, child: _corner(topRight: true)),

          // BOTTOM LEFT
          Positioned(bottom: 4, left: 4, child: _corner(bottomLeft: true)),

          // BOTTOM RIGHT
          Positioned(bottom: 4, right: 4, child: _corner(bottomRight: true)),
        ],
      ),
    );
  }

  Widget _corner({
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    return SizedBox(
      width: bracketLength,
      height: bracketLength,

      child: CustomPaint(
        painter: _CornerBracketPainter(
          color: kBracketColor,
          thickness: bracketThickness,

          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
      ),
    );
  }
}

// ============================================================================
// QR CORNER PAINTER
// ============================================================================

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final double thickness;

  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  _CornerBracketPainter({
    required this.color,
    required this.thickness,

    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (topLeft) {
      path.moveTo(0, size.height);

      path.lineTo(0, 0);

      path.lineTo(size.width, 0);
    } else if (topRight) {
      path.moveTo(0, 0);

      path.lineTo(size.width, 0);

      path.lineTo(size.width, size.height);
    } else if (bottomLeft) {
      path.moveTo(0, 0);

      path.lineTo(0, size.height);

      path.lineTo(size.width, size.height);
    } else if (bottomRight) {
      path.moveTo(size.width, 0);

      path.lineTo(size.width, size.height);

      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) {
    return false;
  }
}

// ============================================================================
// QR PREVIEW DIALOG
// ============================================================================

class QrPreviewDialog extends StatefulWidget {
  final model.Data account;

  const QrPreviewDialog({super.key, required this.account});

  @override
  State<QrPreviewDialog> createState() => _QrPreviewDialogState();
}

class _QrPreviewDialogState extends State<QrPreviewDialog> {
  final GlobalKey _qrKey = GlobalKey();

  bool isSharing = false;

  // ==========================================================================
  // SHARE QR IMAGE
  // ==========================================================================

  Future<void> _shareQrImage() async {
    if (isSharing) return;

    try {
      setState(() {
        isSharing = true;
      });

      // Wait for RepaintBoundary
      await Future.delayed(const Duration(milliseconds: 100));

      final RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception("Unable to create QR image");
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final XFile qrFile = XFile.fromData(
        pngBytes,

        mimeType: 'image/png',

        name: 'upi_qr.png',
      );

      await SharePlus.instance.share(
        ShareParams(
          files: [qrFile],

          title: 'UPI QR Code',

          text: 'Scan this QR code to make payment',

          fileNameOverrides: ['upi_qr.png'],
        ),
      );
    } catch (e) {
      debugPrint("QR Share Error: $e");

      if (mounted) {
        CustomToast.error("Unable to share QR");
      }
    } finally {
      if (mounted) {
        setState(() {
          isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // FULL ACCOUNT NAME
    final String fullAccountName = (widget.account.accountName ?? '').trim();

    return Dialog(
      backgroundColor: Colors.transparent,

      insetPadding: const EdgeInsets.symmetric(horizontal: 48),

      child: RepaintBoundary(
        key: _qrKey,

        child: Container(
          width: double.infinity,

          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2F3349) : Colors.white,

            borderRadius: BorderRadius.circular(8),
          ),

          clipBehavior: Clip.antiAlias,

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              // ============================================================
              // ACCOUNT NAME HEADER
              // ============================================================
              Container(
                width: double.infinity,

                height: 42,

                padding: const EdgeInsets.symmetric(horizontal: 8),

                alignment: Alignment.center,

                color: kHeaderBlue,

                child: FittedBox(
                  fit: BoxFit.scaleDown,

                  child: Text(
                    // FULL ACCOUNT NAME
                    'Account Name : $fullAccountName',

                    textAlign: TextAlign.center,

                    maxLines: 1,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 14,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ============================================================
              // LARGE QR IMAGE
              // ============================================================
              Container(
                width: 200,

                height: 200,

                color: Colors.white,

                padding: const EdgeInsets.all(8),

                child: QrImageView(
                  data: widget.account.upiId ?? '',

                  version: QrVersions.auto,

                  size: 184,

                  backgroundColor: Colors.white,

                  gapless: true,

                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                ),
              ),

              const SizedBox(height: 8),

              // ============================================================
              // SHARE BUTTON
              // ============================================================

              // ============================================================
              // SHARE BUTTON
              // HIDE COMPLETELY WHILE SHARING
              // ============================================================
              if (!isSharing)
                Padding(
                  padding: const EdgeInsets.only(right: 14, bottom: 14),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 43,
                      height: 28,
                      child: OutlinedButton(
                        onPressed: _shareQrImage,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          side: const BorderSide(color: kHeaderBlue, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Icon(Ionicons.share),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
