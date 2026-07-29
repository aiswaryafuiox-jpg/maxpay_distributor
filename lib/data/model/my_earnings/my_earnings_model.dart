class MyEarningsModel {
  bool? success;
  MyEarningsData? data;
  String? message;
  int? code;

  MyEarningsModel({this.success, this.data, this.message, this.code});

  MyEarningsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MyEarningsData.fromJson(json['data']) : null;
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

class MyEarningsData {
  String? totalEarnings;
  List<MyEarningsItem>? list;

  MyEarningsData({this.totalEarnings, this.list});

  MyEarningsData.fromJson(Map<String, dynamic> json) {
    totalEarnings = json['total_earnings']?.toString();
    if (json['list'] != null) {
      list = <MyEarningsItem>[];
      json['list'].forEach((v) {
        list!.add(MyEarningsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_earnings'] = totalEarnings;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyEarningsItem {
  int? id;
  String? transactionNo;
  String? dateTime;
  String? productName;
  String? productType;
  String? productLogo;
  String? transactionAmount;
  String? myEarnings;

  MyEarningsItem({
    this.id,
    this.transactionNo,
    this.dateTime,
    this.productName,
    this.productType,
    this.productLogo,
    this.transactionAmount,
    this.myEarnings,
  });

  MyEarningsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionNo = json['transaction_no']?.toString();
    dateTime = json['date_time']?.toString();
    productName = json['product_name']?.toString();
    productType = json['product_type']?.toString();
    productLogo = json['product_logo']?.toString();
    transactionAmount = json['transaction_amount']?.toString();
    myEarnings = json['my_earnings']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_no'] = transactionNo;
    data['date_time'] = dateTime;
    data['product_name'] = productName;
    data['product_type'] = productType;
    data['product_logo'] = productLogo;
    data['transaction_amount'] = transactionAmount;
    data['my_earnings'] = myEarnings;
    return data;
  }
}
