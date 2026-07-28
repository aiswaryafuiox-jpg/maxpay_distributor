class UpdateStatusSendOtpResponseModel {
  bool? success;
  UpdateStatusData? data;
  String? message;
  int? code;

  UpdateStatusSendOtpResponseModel({this.success, this.data, this.message, this.code});

  UpdateStatusSendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UpdateStatusData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class UpdateStatusData {
  String? phoneNumber;
  bool? otpRequired;
  int? otp;
  int? isActive;

  UpdateStatusData({this.phoneNumber, this.otpRequired, this.otp, this.isActive});

  UpdateStatusData.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    otpRequired = json['otp_required'];
    otp = json['otp'];
    isActive = json['is_active'];
  }
}
