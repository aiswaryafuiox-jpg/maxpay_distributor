import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class ProfileggScreen extends StatefulWidget {
  const ProfileggScreen({super.key});

  @override
  State<ProfileggScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileggScreen> {
  bool isActive = true;
  final ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> _pickProfileImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
    );

    if (image == null || !mounted) {
      return;
    }

    setState(() {
      _profileImage = File(image.path);
    });
  }

  void _showImagePickerOptions() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickProfileImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickProfileImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showStatusPopup() {
    final theme = Theme.of(context);

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                "Are you sure",

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                isActive
                    ? "Are you sure you want to inactive"
                    : "Are you sure you want to active",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  /// CANCEL BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 42,

                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          "Cancel",

                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// YES BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 42,

                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isActive = !isActive;
                          });

                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.clrPrimary,

                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          "Yes",

                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileImageProvider = _profileImage != null
        ? FileImage(_profileImage!)
        : const NetworkImage("https://i.pravatar.cc/300") as ImageProvider;

    return Scaffold(
      appBar: const CommonAppBar(title: "Profile"),
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            MediaQuery.viewInsetsOf(context).bottom + 25,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// PROFILE IMAGE
              Stack(
                children: [
                  Container(
                    width: 95,
                    height: 95,

                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.darkplceholder
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,

                      image: DecorationImage(
                        image: profileImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: GestureDetector(
                      onTap: _showImagePickerOptions,
                      child: Container(
                        width: 28,
                        height: 28,

                        decoration: BoxDecoration(
                          color: AppColors.clrPrimary,

                          shape: BoxShape.circle,

                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        ),

                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              /// NAME
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Name",
                  style: TextHelper.max6.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _buildTextField(context, "William"),

              const SizedBox(height: 18),

              /// PINCODE
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Pin code",
                  style: TextHelper.max6.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _buildTextField(context, "626144"),

              const SizedBox(height: 18),

              /// MAIL
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Mail ID",
                  style: TextHelper.max6.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _buildTextField(context, "Sample@gmail.com"),

              const SizedBox(height: 18),

              /// PHONE
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Phone no",
                  style: TextHelper.max6.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _buildTextField(context, "+91 9876541302"),

              const SizedBox(height: 120),

              /// UPDATE BUTTON
              CommonButton(title: "Update", onTap: () {}),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTextField(BuildContext context, String hint) {
    final theme = Theme.of(context);

    return TextFormField(
      initialValue: hint,

      style: TextStyle(color: theme.colorScheme.onSurface),

      decoration: InputDecoration(
        filled: true,

        fillColor: theme.brightness == Brightness.light
            ? AppColors.border
            : AppColors.darkplceholder,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 16,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(
            color: AppColors.darktextclr.withValues(alpha: 0.1),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(
            color: AppColors.darktextclr.withValues(alpha: 0.1),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
