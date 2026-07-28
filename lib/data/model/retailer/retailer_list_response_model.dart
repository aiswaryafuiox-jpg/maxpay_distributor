class RetailerListResponseModel {
  bool? success;
  RetailerData? data;
  String? message;
  int? code;

  RetailerListResponseModel({this.success, this.data, this.message, this.code});

  RetailerListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? RetailerData.fromJson(json['data']) : null;
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

class RetailerData {
  int? totalRetailer;
  List<Retailer>? list;

  RetailerData({this.totalRetailer, this.list});

  RetailerData.fromJson(Map<String, dynamic> json) {
    totalRetailer = json['total_retailer'];
    if (json['list'] != null) {
      list = <Retailer>[];
      json['list'].forEach((v) {
        list!.add(Retailer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_retailer'] = totalRetailer;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Retailer {
  int? id;
  String? userId;
  String? retailerName;
  String? regMobileNumber;
  num? dueAmount;
  num? walletAmount;
  String? executiveName;
  String? status;
  int? isActive;

  Retailer({
    this.id,
    this.userId,
    this.retailerName,
    this.regMobileNumber,
    this.dueAmount,
    this.walletAmount,
    this.executiveName,
    this.status,
    this.isActive,
  });

  Retailer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    dueAmount = json['due_amount'];
    walletAmount = json['wallet_amount'];
    executiveName = json['executive_name'];
    status = json['status'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['due_amount'] = dueAmount;
    data['wallet_amount'] = walletAmount;
    data['executive_name'] = executiveName;
    data['status'] = status;
    data['is_active'] = isActive;
    return data;
  }
}
