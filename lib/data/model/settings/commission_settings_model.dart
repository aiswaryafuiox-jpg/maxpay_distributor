class CommissionSettingsModel {
  bool? success;
  CommissionSettingsData? data;
  String? message;
  int? code;

  CommissionSettingsModel({this.success, this.data, this.message, this.code});

  CommissionSettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CommissionSettingsData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class CommissionSettingsData {
  List<CommissionSettingItem>? list;

  CommissionSettingsData({this.list});

  CommissionSettingsData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommissionSettingItem>[];
      json['list'].forEach((v) {
        list!.add(CommissionSettingItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommissionSettingItem {
  int? id;
  int? packageId;
  String? packageName;
  int? noOfProducts;
  int? updateProducts;
  int? updatePending;
  String? status;
  String? retailerStatus;
  String? executiveStatus;
  int? canReset;

  CommissionSettingItem({
    this.id,
    this.packageId,
    this.packageName,
    this.noOfProducts,
    this.updateProducts,
    this.updatePending,
    this.status,
    this.retailerStatus,
    this.executiveStatus,
    this.canReset,
  });

  CommissionSettingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageId = json['package_id'];
    packageName = json['package_name'];
    noOfProducts = json['no_of_products'];
    updateProducts = json['update_products'];
    updatePending = json['update_pending'];
    status = json['status'];
    retailerStatus = json['retailer_status'];
    executiveStatus = json['executive_status'];
    canReset = json['can_reset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_id'] = packageId;
    data['package_name'] = packageName;
    data['no_of_products'] = noOfProducts;
    data['update_products'] = updateProducts;
    data['update_pending'] = updatePending;
    data['status'] = status;
    data['retailer_status'] = retailerStatus;
    data['executive_status'] = executiveStatus;
    data['can_reset'] = canReset;
    return data;
  }
}
