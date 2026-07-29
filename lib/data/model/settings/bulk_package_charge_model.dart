class BulkPackageChargeModel {
  bool? success;
  BulkPackageChargeData? data;
  String? message;
  int? code;

  BulkPackageChargeModel({this.success, this.data, this.message, this.code});

  BulkPackageChargeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? BulkPackageChargeData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class BulkPackageChargeData {
  int? packageId;
  String? packageName;
  String? userType;
  int? updatedCount;

  BulkPackageChargeData({
    this.packageId,
    this.packageName,
    this.userType,
    this.updatedCount,
  });

  BulkPackageChargeData.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    packageName = json['package_name'];
    userType = json['user_type'];
    updatedCount = json['updated_count'];
  }
}
