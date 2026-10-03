import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/settings/profile_set/widgets/profile_textfield.dart';
import 'package:get/get.dart';
import '../../../../controller/profile_controller.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: 400,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final profile = controller.profileData.value;
      if (profile == null) {
        return const SizedBox(
          height: 400,
          child: Center(child: Text("No Profile Data Found")),
        );
      }

      return Column(
        children: [
          /// PROFILE IMAGE
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: controller.selectedImage.value != null
                    ? FileImage(controller.selectedImage.value!)
                    : (profile.profileImg != null
                              ? NetworkImage(profile.profileImg!)
                              : const NetworkImage("https://i.pravatar.cc/300"))
                          as ImageProvider,
              ),

              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.clrPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// USER ID
          Text(
            "User ID : ${profile.userId ?? 'N/A'}",
            style: TextHelper.max1.copyWith(
              color: isDark ? AppColors.white : AppColors.profileBlue,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          /// USER TYPE
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "User Type : ",
                  style: TextHelper.max1.copyWith(
                    color: isDark ? AppColors.white : AppColors.profileBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: profile.userType ?? 'N/A',
                  style: TextHelper.max1.copyWith(
                    color: AppColors.retailerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          ProfileTextField(
            title: "Name",
            controller: controller.nameController,
          ),

          const SizedBox(height: 16),

          ProfileTextField(
            title: "Address",
            controller: controller.addressController,
            maxLines: 2,
          ),

          const SizedBox(height: 16),

          ProfileTextField(
            title: "Pin Code",
            controller: controller.pincodeController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            maxLength: 6,
          ),

          const SizedBox(height: 16),

          ProfileTextField(
            title: "Mail ID",
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          ProfileTextField(
            title: "Phone No",
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            maxLength: 10,
          ),

          const SizedBox(height: 16),

          ProfileTextField(
            title: "WhatsApp Number",
            controller: controller.whatsappController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            maxLength: 10,
          ),

          const SizedBox(height: 30),

          Obx(
            () => CommonButton(
              title: controller.isUpdating.value ? "Updating..." : "Update",
              onTap: controller.isUpdating.value
                  ? () {}
                  : () {
                      controller.updateProfileData();
                    },
            ),
          ),

          const SizedBox(height: 20),
        ],
      );
    });
  }
}
