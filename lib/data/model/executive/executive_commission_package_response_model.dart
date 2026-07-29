class ExecutiveCommissionPackageResponseModel {
  bool? success;
  List<ExecutiveCommissionPackage>? data;
  String? message;
  int? code;

  ExecutiveCommissionPackageResponseModel(
      {this.success, this.data, this.message, this.code});

  ExecutiveCommissionPackageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ExecutiveCommissionPackage>[];
      json['data'].forEach((v) {
        data!.add(ExecutiveCommissionPackage.fromJson(v));
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

class ExecutiveCommissionPackage {
  int? id;
  String? packageName;

  ExecutiveCommissionPackage({this.id, this.packageName});

  ExecutiveCommissionPackage.fromJson(Map<String, dynamic> json) {
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
