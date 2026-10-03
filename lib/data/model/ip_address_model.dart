class IpAddressModel {
  bool? success;
  String? message;

  IpAddressModel({this.success, this.message});

  IpAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
