// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:maxpay/core/constants/colors.dart';
//
// class ScreenProfileEdit extends StatefulWidget {
//   const ScreenProfileEdit({super.key});
//
//   @override
//   State<ScreenProfileEdit> createState() => _ScreenProfileEditState();
// }
//
// class _ScreenProfileEditState extends State<ScreenProfileEdit> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//
//   final List<String> _selectedLanguages = ['English', 'Hindi'];
//   final List<String> _selectedInterests = ['Cricket', 'Music', 'Movies'];
//   String? _profileImagePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = "Aswanth";
//     _dobController.text = "01-01-1995";
//     _designationController.text = "Developer";
//     _phoneNumberController.text = "+91 9876543210";
//     _bioController.text = "Flutter developer with a passion for clean UI.";
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _dobController.dispose();
//     _designationController.dispose();
//     _phoneNumberController.dispose();
//     _bioController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: EdgeInsets.fromLTRB(
//             16.w,
//             10.h,
//             16.w,
//             MediaQuery.viewInsetsOf(context).bottom + 30.h,
//           ),
//           child: Column(
//             children: [
//               /// 🔹 HEADER
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => context.pop(),
//                     child: Container(
//                       width: 45.w,
//                       height: 45.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.grey.withValues(alpha: 0.3),
//                         ),
//                         color: theme.colorScheme.surface,
//                       ),
//                       child: const Center(
//                         child: Icon(Icons.arrow_back_ios, size: 18),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         "Manage Profile",
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           fontFamily: 'Poppins',
//                           color: isDark ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 45.w),
//                 ],
//               ),
//               SizedBox(height: 25.h),
//
//               /// 🔹 PROFILE IMAGE
//               Stack(
//                 children: [
//                   Container(
//                     width: 130.w,
//                     height: 130.w,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.grey.withValues(alpha: 0.2),
//                       image: _profileImagePath != null
//                           ? DecorationImage(
//                               fit: BoxFit.cover,
//                               image: FileImage(File(_profileImagePath!)),
//                             )
//                           : null,
//                     ),
//                     child: _profileImagePath == null
//                         ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
//                         : null,
//                   ),
//                   Positioned(
//                     bottom: 5,
//                     right: 5,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Handle image selection
//                       },
//                       child: Container(
//                         height: 35.w,
//                         width: 35.w,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.clrPrimary,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                         child: Icon(
//                           Icons.camera_alt_outlined,
//                           color: Colors.white,
//                           size: 18.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30.h),
//
//               /// 🔹 FORM FIELDS
//               _buildTextField('Full name', _nameController, isDark),
//               _buildTextField('Date of birth', _dobController, isDark),
//               _buildTextField('Designation', _designationController, isDark),
//               _buildTextField(
//                 'Phone number',
//                 _phoneNumberController,
//                 isDark,
//                 isReadOnly: true,
//               ),
//               _buildTextField(
//                 'Bio/About me',
//                 _bioController,
//                 isDark,
//                 maxLines: 4,
//               ),
//
//               SizedBox(height: 20.h),
//
//               /// 🔹 LANGUAGES SECTION
//               _buildTagsSection(
//                 context,
//                 "Languages",
//                 _selectedLanguages,
//                 isDark,
//                 onEditTap: () {},
//               ),
//               SizedBox(height: 20.h),
//
//               /// 🔹 INTERESTS SECTION
//               _buildTagsSection(
//                 context,
//                 "Interests",
//                 _selectedInterests,
//                 isDark,
//                 onEditTap: () {},
//               ),
//
//               SizedBox(height: 40.h),
//
//               /// 🔹 SAVE BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 50.h,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     context.pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.clrPrimary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                   child: Text(
//                     'Save Profile',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15.h),
//
//               /// 🔹 DELETE BUTTON
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Delete Account',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//     String label,
//     TextEditingController controller,
//     bool isDark, {
//     int maxLines = 1,
//     bool isReadOnly = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: 8.h),
//           Container(
//             decoration: BoxDecoration(
//               color: isDark
//                   ? AppColors.darkplceholder
//                   : AppColors.clrplceholder,
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: TextField(
//               controller: controller,
//               readOnly: isReadOnly,
//               maxLines: maxLines,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 color: isDark ? Colors.white : Colors.black,
//               ),
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 16.w,
//                   vertical: 12.h,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTagsSection(
//     BuildContext context,
//     String title,
//     List<String> tags,
//     bool isDark, {
//     required VoidCallback onEditTap,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkplceholder : AppColors.clrplceholder,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: isDark ? Colors.white : Colors.black,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onEditTap,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 12.w,
//                     vertical: 4.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withValues(alpha: 0.15),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "Edit",
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Wrap(
//             spacing: 8.w,
//             runSpacing: 8.h,
//             children: tags.map((tag) => _buildTagChip(tag, isDark)).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTagChip(String label, bool isDark) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//       decoration: BoxDecoration(
//         color: AppColors.clrPrimary.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.clrPrimary.withValues(alpha: 0.2)),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: AppColors.clrPrimary,
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:maxpay/core/constants/colors.dart';
// import 'package:maxpay/core/utils/texthelper.dart';
// import 'package:maxpay/global_widget/commom_button.dart';
// import 'package:maxpay/global_widget/custom_app.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   bool isActive = true;
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _profileImage;
//
//   Future<void> _pickProfileImage(ImageSource source) async {
//     final image = await _imagePicker.pickImage(
//       source: source,
//       imageQuality: 85,
//       maxWidth: 800,
//     );
//
//     if (image == null || !mounted) {
//       return;
//     }
//
//     setState(() {
//       _profileImage = File(image.path);
//     });
//   }
//
//   void _showImagePickerOptions() {
//     final theme = Theme.of(context);
//
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: theme.colorScheme.surface,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
//       ),
//       builder: (context) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.camera_alt_outlined),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickProfileImage(ImageSource.camera);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.photo_library_outlined),
//                   title: const Text('Gallery'),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pickProfileImage(ImageSource.gallery);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void showStatusPopup() {
//     final theme = Theme.of(context);
//
//     showDialog(
//       context: context,
//
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: theme.colorScheme.surface,
//
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//
//             children: [
//               Text(
//                 "Are you sure",
//
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: theme.colorScheme.onSurface,
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//
//               Text(
//                 isActive
//                     ? "Are you sure you want to inactive"
//                     : "Are you sure you want to active",
//
//                 textAlign: TextAlign.center,
//
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: theme.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//
//               const SizedBox(height: 22),
//
//               Row(
//                 children: [
//                   /// CANCEL BUTTON
//                   Expanded(
//                     child: SizedBox(
//                       height: 42,
//
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: Colors.red),
//
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//
//                         child: const Text(
//                           "Cancel",
//
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 14),
//
//                   /// YES BUTTON
//                   Expanded(
//                     child: SizedBox(
//                       height: 42,
//
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isActive = !isActive;
//                           });
//
//                           Navigator.pop(context);
//                         },
//
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.clrPrimary,
//
//                           elevation: 0,
//
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//
//                         child: const Text(
//                           "Yes",
//
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final profileImageProvider = _profileImage != null
//         ? FileImage(_profileImage!)
//         : const NetworkImage("https://i.pravatar.cc/300") as ImageProvider;
//
//     return Scaffold(
//       appBar: const CommonAppBar(title: "Profile"),
//       resizeToAvoidBottomInset: false,
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           padding: EdgeInsets.fromLTRB(
//             20,
//             0,
//             20,
//             MediaQuery.viewInsetsOf(context).bottom + 25,
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//
//               /// PROFILE IMAGE
//               Stack(
//                 children: [
//                   Container(
//                     width: 95,
//                     height: 95,
//
//                     decoration: BoxDecoration(
//                       color: theme.brightness == Brightness.dark
//                           ? AppColors.darkplceholder
//                           : Colors.grey.shade200,
//                       shape: BoxShape.circle,
//
//                       image: DecorationImage(
//                         image: profileImageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//
//                     child: GestureDetector(
//                       onTap: _showImagePickerOptions,
//                       child: Container(
//                         width: 28,
//                         height: 28,
//
//                         decoration: BoxDecoration(
//                           color: AppColors.clrPrimary,
//
//                           shape: BoxShape.circle,
//
//                           border: Border.all(
//                             color: theme.colorScheme.surface,
//                             width: 2,
//                           ),
//                         ),
//
//                         child: const Icon(
//                           Icons.camera_alt_outlined,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 28),
//
//               /// NAME
//               Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text(
//                   "Name",
//                   style: TextHelper.max6.copyWith(
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               _buildTextField(context, "William"),
//
//               const SizedBox(height: 18),
//
//               /// PINCODE
//               Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text(
//                   "Pin code",
//                   style: TextHelper.max6.copyWith(
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               _buildTextField(context, "626144"),
//
//               const SizedBox(height: 18),
//
//               /// MAIL
//               Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text(
//                   "Mail ID",
//                   style: TextHelper.max6.copyWith(
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               _buildTextField(context, "Sample@gmail.com"),
//
//               const SizedBox(height: 18),
//
//               /// PHONE
//               Align(
//                 alignment: Alignment.centerLeft,
//
//                 child: Text(
//                   "Phone no",
//                   style: TextHelper.max6.copyWith(
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               _buildTextField(context, "+91 9876541302"),
//
//               const SizedBox(height: 120),
//
//               /// UPDATE BUTTON
//               CommonButton(title: "Update", onTap: () {}),
//
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget _buildTextField(BuildContext context, String hint) {
//     final theme = Theme.of(context);
//
//     return TextFormField(
//       initialValue: hint,
//
//       style: TextStyle(color: theme.colorScheme.onSurface),
//
//       decoration: InputDecoration(
//         filled: true,
//
//         fillColor: theme.brightness == Brightness.light
//             ? AppColors.border
//             : AppColors.darkplceholder,
//
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 16,
//         ),
//
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//
//           borderSide: BorderSide(
//             color: AppColors.darktextclr.withValues(alpha: 0.1),
//           ),
//         ),
//
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//
//           borderSide: BorderSide(
//             color: AppColors.darktextclr.withValues(alpha: 0.1),
//           ),
//         ),
//
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//
//           borderSide: BorderSide(color: theme.colorScheme.primary),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/view/settings/profile_set/widgets/profile_form.dart';
import 'package:get/get.dart';
import '../../../../controller/profile_controller.dart';
import '../../../../core/di/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    Get.put(ProfileController(sl(), sl(), sl(), sl(), sl(), sl()));
    isActive = Get.find<ProfileController>().profileData.value?.isActive == 1
        ? true
        : false;
  }

  Future<void> _showStatusDialog() async {
    final action = isActive ? "inactive" : "active";

    final bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkplceholder : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Are you sure",
            textAlign: TextAlign.center,
            style: TextHelper.max10(context),
          ),
          content: Text(
            "Are you sure you want to $action",
            textAlign: TextAlign.center,
            style: TextHelper.max9(context),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final controller = Get.find<ProfileController>();
                      controller.updateStatusSendOtp(isActive ? 0 : 1);
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.clrPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (result == true) {
      setState(() {
        isActive = !isActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: CommonAppBar(
        title: "Profile",

        action: GestureDetector(
          onTap: _showStatusDialog,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? (isDark ? const Color(0xFF0B4A2D) : AppColors.active1Bg)
                  : AppColors.inactiveBg,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                isActive ? "Active" : "Inactive",
                style: TextHelper.max1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),

      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ProfileForm(),
        ),
      ),
    );
  }
}
