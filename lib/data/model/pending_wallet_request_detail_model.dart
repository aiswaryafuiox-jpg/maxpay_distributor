class PendingWalletRequestDetailModel {
  bool? success;
  PendingWalletRequestDetailData? data;
  String? message;
  int? code;

  PendingWalletRequestDetailModel({this.success, this.data, this.message, this.code});

  PendingWalletRequestDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PendingWalletRequestDetailData.fromJson(json['data']) : null;
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

class PendingWalletRequestDetailData {
  int? id;
  String? dateTime;
  String? retailerName;
  String? regMobileNumber;
  String? paymentStatus;
  String? paymentMode;
  String? utrNo;
  String? receipt;
  dynamic amount;
  String? description;
  String? status;

  PendingWalletRequestDetailData(
      {this.id,
      this.dateTime,
      this.retailerName,
      this.regMobileNumber,
      this.paymentStatus,
      this.paymentMode,
      this.utrNo,
      this.receipt,
      this.amount,
      this.description,
      this.status});

  PendingWalletRequestDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['date_time'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    paymentStatus = json['payment_status'];
    paymentMode = json['payment_mode'];
    utrNo = json['utr_no'];
    receipt = json['receipt'];
    amount = json['amount'];
    description = json['description'];
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
    data['utr_no'] = utrNo;
    data['receipt'] = receipt;
    data['amount'] = amount;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
