class OnlineTransactionModel {
  bool? success;
  OnlineTransactionData? data;
  String? message;
  int? code;

  OnlineTransactionModel({this.success, this.data, this.message, this.code});

  OnlineTransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? OnlineTransactionData.fromJson(json['data']) : null;
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

class OnlineTransactionData {
  List<OnlineTransactionItem>? list;

  OnlineTransactionData({this.list});

  OnlineTransactionData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <OnlineTransactionItem>[];
      json['list'].forEach((v) {
        list!.add(OnlineTransactionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OnlineTransactionItem {
  String? id;
  String? dateTime;
  String? retailerName;
  String? mobileNo;
  String? amount;
  String? status;

  OnlineTransactionItem({
    this.id,
    this.dateTime,
    this.retailerName,
    this.mobileNo,
    this.amount,
    this.status,
  });

  OnlineTransactionItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    dateTime = json['date_time']?.toString() ?? json['created_at']?.toString();
    retailerName = json['retailer_name']?.toString() ?? json['user_name']?.toString();
    mobileNo = json['mobile_no']?.toString() ?? json['mobile']?.toString();
    amount = json['amount']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['date_time'] = dateTime;
    map['retailer_name'] = retailerName;
    map['mobile_no'] = mobileNo;
    map['amount'] = amount;
    map['status'] = status;
    return map;
  }
}
