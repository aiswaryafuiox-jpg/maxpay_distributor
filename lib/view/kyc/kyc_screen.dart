import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  PlatformFile? _addressProofFile;
  PlatformFile? _gstFile;
  PlatformFile? _panCardFile;

  Future<void> _pickGalleryFile(ValueChanged<PlatformFile> onPicked) async {
    try {
      final result = await _openGalleryPicker();
      _setPickedFile(result, onPicked);
    } on PlatformException catch (error) {
      if (!mounted) return;

      try {
        final result = await _openImageDocumentPicker();
        _setPickedFile(result, onPicked);
      } catch (_) {
        debugPrint(error.message ?? 'Unable to open gallery');
      }
    } catch (_) {
      if (!mounted) return;

      debugPrint('Unable to pick image');
    }
  }

  Future<FilePickerResult?> _openGalleryPicker() {
    return FilePicker.pickFiles(type: FileType.image, allowMultiple: false);
  }

  Future<FilePickerResult?> _openImageDocumentPicker() {
    return FilePicker.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'heic', 'heif'],
    );
  }

  void _setPickedFile(
    FilePickerResult? result,
    ValueChanged<PlatformFile> onPicked,
  ) {
    if (!mounted || result == null || result.files.isEmpty) return;

    setState(() {
      onPicked(result.files.single);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "KYC"),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// MAIL ID
                      Text(
                        "Mail ID",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),
                      /// MAIL ID


                      /// INPUT FIELD
                      Container(
                        height: 52,

                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.light
                              ? AppColors.border
                              : const Color(0xFF2F3349),

                          borderRadius: BorderRadius.circular(10),

                          border: Border.all(
                            color: AppColors.darktextclr.withValues(alpha: 0.1),
                          ),
                        ),

                        child: TextFormField(
                          style: TextStyle(color: theme.colorScheme.onSurface),

                          decoration: InputDecoration(
                            //hintText: "Enter your mail id",

                            hintStyle: TextStyle(
                              // color: theme.colorScheme.onSurfaceVariant,
                                 color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : theme.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),

                            border: InputBorder.none,

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),
                      /// MAIL ID
                      Text(
                        "WhatsApp Number",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),
                      /// MAIL ID


                      /// INPUT FIELD
                      Container(
                        height: 52,

                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.light
                              ? AppColors.border
                              : const Color(0xFF2F3349),

                          borderRadius: BorderRadius.circular(10),

                          border: Border.all(
                            color: AppColors.darktextclr.withValues(alpha: 0.1),
                          ),
                        ),

                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(color: theme.colorScheme.onSurface),

                          decoration: InputDecoration(


                            hintStyle: TextStyle(
                              // color: theme.colorScheme.onSurfaceVariant,
                              color: isDark
                                  ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                                  : theme.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),

                            border: InputBorder.none,

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),


                      /// ADDRESS PROOF
                      Text(
                        "Cancelled Check",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _addressProofFile,
                        onTap: () => _pickGalleryFile(
                          (file) => _addressProofFile = file,
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// GST NO
                      Text(
                        "GST No",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _gstFile,
                        onTap: () =>
                            _pickGalleryFile((file) => _gstFile = file),
                      ),

                      const SizedBox(height: 22),

                      /// PAN CARD
                      Text(
                        "Pan Card",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _panCardFile,
                        onTap: () =>
                            _pickGalleryFile((file) => _panCardFile = file),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              /// SUBMIT BUTTON
              CommonButton(title: "Submit", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadCard extends StatelessWidget {
  const UploadCard({super.key, required this.onTap, this.file});

  final VoidCallback onTap;
  final PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

          decoration: BoxDecoration(
            color: theme.brightness == Brightness.light
                ? AppColors.border
                : const Color(0xFF2F3349),

            borderRadius: BorderRadius.circular(12),

            border: Border.all(
              color: AppColors.darktextclr.withValues(alpha: 0.1),
            ),
          ),

          child: Column(
            children: [
              if (file?.path != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(file!.path!),
                    height: 90,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 26,
                  color: theme.colorScheme.onSurface,
                ),
              ],

              const SizedBox(height: 12),

              Text(
                "Browse and choose the files you want to upload\nfrom your Device",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                 color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                height: 34,
                width: 34,

                decoration: BoxDecoration(
                  color: const Color(0xff0C8A5B),

                  borderRadius: BorderRadius.circular(6),
                ),

                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),

              if (file != null) ...[
                const SizedBox(height: 12),
                Text(
                  file!.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
