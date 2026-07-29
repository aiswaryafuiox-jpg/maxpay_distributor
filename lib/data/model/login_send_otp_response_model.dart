class LoginSendOtpResponseModel {
  final bool? success;
  final LoginData? data;
  final String? message;
  final int? code;

  LoginSendOtpResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory LoginSendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginSendOtpResponseModel(
      success: json['success'],
      data: json['data'] != null
          ? LoginData.fromJson(json['data'])
          : null,
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

class LoginData {
  final String? name;
  final String? phoneNumber;
  final String? pincode;
  final int? otp;

  LoginData({
    this.name,
    this.phoneNumber,
    this.pincode,
    this.otp,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      name: json['name'],
      phoneNumber: json['phone_number'],
      pincode: json['pincode'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'pincode': pincode,
      'otp': otp,
    };
  }
}