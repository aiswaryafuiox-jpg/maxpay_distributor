class RegChargeDetailModel {
  bool? success;
  RegChargeDetailData? data;
  String? message;
  int? code;

  RegChargeDetailModel({this.success, this.data, this.message, this.code});

  RegChargeDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? RegChargeDetailData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}

class RegChargeDetailData {
  num? totalDistributorCommission;
  num? totalExecutiveCommission;
  List<RegChargeDetailItem>? list;

  RegChargeDetailData({
    this.totalDistributorCommission,
    this.totalExecutiveCommission,
    this.list,
  });

  RegChargeDetailData.fromJson(Map<String, dynamic> json) {
    totalDistributorCommission = json['total_distributor_commission'];
    totalExecutiveCommission = json['total_executive_commission'];
    if (json['list'] != null) {
      list = <RegChargeDetailItem>[];
      json['list'].forEach((v) {
        list!.add(RegChargeDetailItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['total_distributor_commission'] = totalDistributorCommission;
    map['total_executive_commission'] = totalExecutiveCommission;
    if (list != null) {
      map['list'] = list!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class RegChargeDetailItem {
  String? id;
  String? createdAt;
  String? retailerName;
  String? amount;
  String? commission;
  String? status;

  RegChargeDetailItem({
    this.id,
    this.createdAt,
    this.retailerName,
    this.amount,
    this.commission,
    this.status,
  });

  RegChargeDetailItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    createdAt = json['created_at']?.toString() ?? json['date_time']?.toString();
    retailerName = json['retailer_name']?.toString() ?? json['user_name']?.toString();
    amount = json['amount']?.toString() ?? json['charge_amount']?.toString();
    commission = json['commission']?.toString() ?? json['commission_amount']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['retailer_name'] = retailerName;
    map['amount'] = amount;
    map['commission'] = commission;
    map['status'] = status;
    return map;
  }
}
