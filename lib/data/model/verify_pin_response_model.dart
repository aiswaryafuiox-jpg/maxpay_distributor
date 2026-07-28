class VerifyPinResponseModel {
  final bool? success;
  final dynamic data;
  final String? message;
  final int? code;

  VerifyPinResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory VerifyPinResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyPinResponseModel(
      success: json['success'],
      data: json['data'],
      message: json['message'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'code': code,
    };
  }
}
