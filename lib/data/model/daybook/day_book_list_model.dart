class DayBookListModel {
  bool? success;
  DayBookData? data;
  String? message;
  int? code;

  DayBookListModel({this.success, this.data, this.message, this.code});

  DayBookListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DayBookData.fromJson(json['data']) : null;
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

class DayBookData {
  String? totalAmount;
  List<DayBookItem>? list;

  DayBookData({this.totalAmount, this.list});

  DayBookData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount']?.toString();
    if (json['list'] != null) {
      list = <DayBookItem>[];
      json['list'].forEach((v) {
        list!.add(DayBookItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_amount'] = totalAmount;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayBookItem {
  String? retailerName;
  String? mobileNo;
  String? transactionId;
  String? transactionType;
  String? amount;
  String? dateTime;

  DayBookItem({
    this.retailerName,
    this.mobileNo,
    this.transactionId,
    this.transactionType,
    this.amount,
    this.dateTime,
  });

  DayBookItem.fromJson(Map<String, dynamic> json) {
    retailerName = json['retailer_name'] ?? json['name']?.toString();
    mobileNo = json['mobile_no'] ?? json['phone_number']?.toString();
    transactionId = json['transaction_id']?.toString() ?? json['id']?.toString();
    transactionType = json['transaction_type']?.toString();
    amount = json['amount']?.toString() ?? json['received_amount']?.toString();
    dateTime = json['date_time'] ?? json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retailer_name'] = retailerName;
    data['mobile_no'] = mobileNo;
    data['transaction_id'] = transactionId;
    data['transaction_type'] = transactionType;
    data['amount'] = amount;
    data['date_time'] = dateTime;
    return data;
  }
}
