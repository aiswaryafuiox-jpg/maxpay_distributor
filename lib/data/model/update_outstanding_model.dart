class UpdateOutstandingModel {
  bool? success;
  dynamic data;
  String? message;
  int? code;

  UpdateOutstandingModel({this.success, this.data, this.message, this.code});

  UpdateOutstandingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
