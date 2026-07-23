import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/view/settings/profile_set/widgets/profile_textfield.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PROFILE IMAGE
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),

            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.clrPrimary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// USER ID
        Text(
          "User ID : RT0122154",
          style: TextHelper.max1.copyWith(
            color: AppColors.profileBlue,
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
                  color: AppColors.profileBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: "Retailer",
                style: TextHelper.max1.copyWith(
                  color: AppColors.retailerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        const ProfileTextField(
          title: "Name",
          value: "William",
        ),

        const SizedBox(height: 16),

        const ProfileTextField(
          title: "Address",
          value: "Kanyakumari",
          maxLines: 2,
        ),

        const SizedBox(height: 16),

        const ProfileTextField(
          title: "Pin Code",
          value: "626144",
        ),

        const SizedBox(height: 16),

        const ProfileTextField(
          title: "Mail ID",
          value: "sample@gmail.com",
        ),

        const SizedBox(height: 16),

        const ProfileTextField(
          title: "Phone No",
          value: "+91 9876541302",
        ),

        const SizedBox(height: 16),

        const ProfileTextField(
          title: "WhatsApp Number",
          value: "+91 9876541302",
        ),

        const SizedBox(height: 30),

        CommonButton(
          title: "Update",
          onTap: () {
            // TODO: Update profile
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}