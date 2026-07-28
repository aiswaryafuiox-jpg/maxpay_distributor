class CommissionPackageResponseModel {
  bool? success;
  List<CommissionPackageData>? data;
  String? message;
  int? code;

  CommissionPackageResponseModel(
      {this.success, this.data, this.message, this.code});

  CommissionPackageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CommissionPackageData>[];
      json['data'].forEach((v) {
        data!.add(CommissionPackageData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class CommissionPackageData {
  int? id;
  String? packageName;

  CommissionPackageData({this.id, this.packageName});

  CommissionPackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['package_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    return data;
  }
}
