class UpdateRetailerResponseModel {
  bool? success;
  String? message;
  int? code;

  UpdateRetailerResponseModel({this.success, this.message, this.code});

  UpdateRetailerResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
