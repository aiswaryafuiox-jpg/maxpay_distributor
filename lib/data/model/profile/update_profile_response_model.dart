class UpdateProfileResponseModel {
  bool? success;
  UpdateProfileData? data;
  String? message;
  int? code;

  UpdateProfileResponseModel({this.success, this.data, this.message, this.code});

  UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? UpdateProfileData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class UpdateProfileData {
  String? userId;
  String? phoneNumber;
  bool? otpRequired;
  int? otp;

  UpdateProfileData({this.userId, this.phoneNumber, this.otpRequired, this.otp});

  UpdateProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    otpRequired = json['otp_required'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['phone_number'] = phoneNumber;
    data['otp_required'] = otpRequired;
    data['otp'] = otp;
    return data;
  }
}
