class CreatePinResponseModel {
  final bool? success;
  final dynamic data;
  final String? message;
  final int? code;

  CreatePinResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory CreatePinResponseModel.fromJson(Map<String, dynamic> json) {
    return CreatePinResponseModel(
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
