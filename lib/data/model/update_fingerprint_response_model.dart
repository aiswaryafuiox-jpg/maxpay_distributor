class UpdateFingerprintResponseModel {
  final bool? success;
  final dynamic data;
  final String? message;
  final int? code;

  UpdateFingerprintResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory UpdateFingerprintResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateFingerprintResponseModel(
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
