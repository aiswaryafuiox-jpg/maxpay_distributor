class PendingWalletRequestModel {
  bool? success;
  PendingWalletRequestData? data;
  String? message;
  int? code;

  PendingWalletRequestModel({this.success, this.data, this.message, this.code});

  PendingWalletRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PendingWalletRequestData.fromJson(json['data']) : null;
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

class PendingWalletRequestData {
  int? total;
  List<PendingWalletRequestItem>? list;

  PendingWalletRequestData({this.total, this.list});

  PendingWalletRequestData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <PendingWalletRequestItem>[];
      json['list'].forEach((v) {
        list!.add(PendingWalletRequestItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingWalletRequestItem {
  int? id;
  String? dateTime;
  String? retailerName;
  String? regMobileNumber;
  String? paymentStatus;
  String? paymentMode;
  dynamic amount;
  String? status;

  PendingWalletRequestItem(
      {this.id,
      this.dateTime,
      this.retailerName,
      this.regMobileNumber,
      this.paymentStatus,
      this.paymentMode,
      this.amount,
      this.status});

  PendingWalletRequestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['date_time'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    paymentStatus = json['payment_status'];
    paymentMode = json['payment_mode'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_time'] = dateTime;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['payment_status'] = paymentStatus;
    data['payment_mode'] = paymentMode;
    data['amount'] = amount;
    data['status'] = status;
    return data;
  }
}
