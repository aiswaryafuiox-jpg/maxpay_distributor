class LoginVerifyOtpResponseModel {
  final bool? success;
  final VerifyOtpData? data;
  final String? message;
  final int? code;

  LoginVerifyOtpResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory LoginVerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginVerifyOtpResponseModel(
      success: json['success'],
      data: json['data'] != null ? VerifyOtpData.fromJson(json['data']) : null,
      message: json['message'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class VerifyOtpData {
  final int? isNewUser;
  final int? isPin;
  final int? isFingerPrint;
  final String? token;

  VerifyOtpData({
    this.isNewUser,
    this.isPin,
    this.isFingerPrint,
    this.token,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      isNewUser: json['is_new_user'],
      isPin: json['is_pin'],
      isFingerPrint: json['is_finger_print'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_new_user': isNewUser,
      'is_pin': isPin,
      'is_finger_print': isFingerPrint,
      'token': token,
    };
  }
}
