import 'package:maxpay/core/utils/custom_snackbar.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/logg_helper.dart';
import '../domain/usecase/profile/get_profile_usecase.dart';
import '../domain/usecase/profile/update_profile_usecase.dart';
import '../domain/usecase/profile/verify_update_profile_otp_usecase.dart';
import '../domain/usecase/profile/resend_update_profile_otp_usecase.dart';
import '../domain/usecase/profile/update_status_send_otp_usecase.dart';
import '../domain/usecase/profile/verify_update_status_otp_usecase.dart';
import '../data/model/profile/get_profile_response_model.dart';
import '../view/settings/profile_set/profile_update_otp_screen.dart';
import '../view/settings/profile_set/status_update_otp_screen.dart';
import '../core/utils/sim_util.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final VerifyUpdateProfileOtpUseCase verifyUpdateProfileOtpUseCase;
  final ResendUpdateProfileOtpUseCase resendUpdateProfileOtpUseCase;
  final UpdateStatusSendOtpUseCase updateStatusSendOtpUseCase;
  final VerifyUpdateStatusOtpUseCase verifyUpdateStatusOtpUseCase;

  ProfileController(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.verifyUpdateProfileOtpUseCase,
    this.resendUpdateProfileOtpUseCase,
    this.updateStatusSendOtpUseCase,
    this.verifyUpdateStatusOtpUseCase,
  );

  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;
  Rx<ProfileData?> profileData = ProfileData().obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  int pendingStatusUpdateIsActive = 1;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile({int retryCount = 0, int maxRetries = 3}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null || token.isEmpty) {
      return;
    }

    if (retryCount == 0) isLoading.value = true;
    final result = await getProfileUseCase.call();

    if (isClosed) return;

    await result.fold(
      (failure) async {
        if (retryCount < maxRetries) {
          await Future.delayed(const Duration(seconds: 2));
          if (!isClosed) {
            await fetchProfile(
              retryCount: retryCount + 1,
              maxRetries: maxRetries,
            );
          }
        } else {
          isLoading.value = false;
          CustomSnackbar.error(failure.message);
          AppLogger.logError("Failed to fetch profile: ${failure.message}");
        }
      },
      (data) async {
        // If data is null for a new user, retry a few times
        if (data.data == null && retryCount < maxRetries) {
          await Future.delayed(const Duration(seconds: 2));
          if (!isClosed) {
            await fetchProfile(
              retryCount: retryCount + 1,
              maxRetries: maxRetries,
            );
          }
        } else {
          isLoading.value = false;
          profileData.value = data.data;
          profileData.refresh();

          nameController.text = data.data?.name ?? '';
          addressController.text = data.data?.address ?? '';
          pincodeController.text = data.data?.pincode ?? '';
          emailController.text = data.data?.email ?? '';
          phoneController.text = data.data?.phoneNumber ?? '';
          whatsappController.text = data.data?.whatsappNumber ?? '';

          AppLogger.debugPrint(
            "Profile fetched successfully: ${data.data?.name}",
          );
        }
      },
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfileData() async {
    isUpdating.value = true;

    final Map<String, dynamic> formDataMap = {
      'name': nameController.text.trim(),
      'address': addressController.text.trim(),
      'pincode': pincodeController.text.trim(),
      'email': emailController.text.trim(),
      'phone_number': phoneController.text.trim(),
      'whatsapp_number': whatsappController.text.trim(),
    };

    if (selectedImage.value != null) {
      formDataMap['profile_img'] = await dio.MultipartFile.fromFile(
        selectedImage.value!.path,
        filename: selectedImage.value!.path.split('/').last,
      );
    }

    final formData = dio.FormData.fromMap(formDataMap);
    final result = await updateProfileUseCase.call(formData);

    result.fold(
      (failure) {
        isUpdating.value = false;
        CustomSnackbar.error(failure.message);
        AppLogger.logError("Failed to update profile: ${failure.message}");
      },
      (data) {
        isUpdating.value = false;
        if (data.data?.otpRequired == true) {
          AppLogger.debugPrint(
            "Profile update initiated. OTP sent to: ${data.data?.phoneNumber}",
          );

          // Temporarily showing the OTP in snackbar if returning for dev testing.
          // CustomSnackbar.success(//   "${data.message ?? ''} ${data.data?.otp != null ? 'OTP: ${data.data?.otp}' : ''}");
          String toastMsg = "OTP Sent Successfully";
          if (data.data?.phoneNumber != null &&
              SimUtil.testNumbers.contains(data.data?.phoneNumber)) {
            toastMsg = "OTP: ${data.data?.otp}";
          }

          Fluttertoast.showToast(
            msg: toastMsg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Get.to(() => const ProfileUpdateOtpScreen(), arguments: data);
        } else {
          CustomSnackbar.success(data.message ?? "Profile updated successfully");
          fetchProfile(); // Reload the profile if no OTP is required
        }
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    isUpdating.value = true;
    final result = await verifyUpdateProfileOtpUseCase.call(otp);

    result.fold(
      (failure) {
        isUpdating.value = false;
        CustomSnackbar.error(failure.message);
      },
      (data) {
        isUpdating.value = false;
        profileData.value = data.data; // Update local data with verified data
        Get.back(); // Close OTP screen
        CustomSnackbar.success(data.message ?? "Profile updated successfully");
      },
    );
  }

  Future<void> resendOtp() async {
    isUpdating.value = true;
    final result = await resendUpdateProfileOtpUseCase.call();

    result.fold(
      (failure) {
        isUpdating.value = false;
        CustomSnackbar.error(failure.message);
      },
      (data) {
        isUpdating.value = false;
        String toastMsg = "OTP Sent Successfully";
        if (data.data?.phoneNumber != null &&
            SimUtil.testNumbers.contains(data.data?.phoneNumber)) {
          toastMsg = "OTP: ${data.data?.otp}";
        }

        Fluttertoast.showToast(
          msg: toastMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }

  Future<void> updateStatusSendOtp(int isActive) async {
    isUpdating.value = true;
    pendingStatusUpdateIsActive = isActive;
    final result = await updateStatusSendOtpUseCase.call(isActive);

    result.fold(
      (failure) {
        isUpdating.value = false;
        CustomSnackbar.error(failure.message);
      },
      (data) {
        isUpdating.value = false;
        if (data.data?.otpRequired == true) {
          String toastMsg = "OTP Sent Successfully";
          if (data.data?.phoneNumber != null &&
              SimUtil.testNumbers.contains(data.data?.phoneNumber)) {
            toastMsg = "OTP: ${data.data?.otp}";
          }

          Fluttertoast.showToast(
            msg: toastMsg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.to(() => const StatusUpdateOtpScreen(), arguments: data);
        } else {
          CustomSnackbar.success(data.message ?? "Status updated successfully");
          fetchProfile(); // Reload the profile if no OTP is required
        }
      },
    );
  }

  Future<void> verifyStatusOtp(String otp) async {
    isUpdating.value = true;
    final result = await verifyUpdateStatusOtpUseCase.call(otp);

    result.fold(
      (failure) {
        isUpdating.value = false;
        CustomSnackbar.error(failure.message);
      },
      (data) {
        isUpdating.value = false;
        profileData.value = data.data; // Update local data with verified data
        Get.back(); // Close OTP screen
        CustomSnackbar.success(data.message ?? "Status updated successfully");
      },
    );
  }

  Future<void> resendStatusOtp() async {
    await updateStatusSendOtp(pendingStatusUpdateIsActive);
  }
}
