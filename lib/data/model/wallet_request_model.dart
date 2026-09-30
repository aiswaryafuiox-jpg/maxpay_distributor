class WalletRequest {
  bool? success;
  Data? data;
  String? message;
  int? code;

  WalletRequest({this.success, this.data, this.message, this.code});

  WalletRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  int? retailerId;
  String? retailerUserId;
  int? bankId;
  String? userType;
  String? paymentFor;
  String? outstandingAmount;
  String? requestAmount;
  String? paymentType;
  String? bankName;
  String? refNumber;
  String? receipt;
  String? description;
  String? remark;
  String? txnId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.retailerId,
      this.retailerUserId,
      this.bankId,
      this.userType,
      this.paymentFor,
      this.outstandingAmount,
      this.requestAmount,
      this.paymentType,
      this.bankName,
      this.refNumber,
      this.receipt,
      this.description,
      this.remark,
      this.txnId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    retailerUserId = json['retailer_user_id'];
    bankId = json['bank_id'];
    userType = json['user_type'];
    paymentFor = json['payment_for'];
    outstandingAmount = json['outstanding_amount'];
    requestAmount = json['request_amount'];
    paymentType = json['payment_type'];
    bankName = json['bank_name'];
    refNumber = json['ref_number'];
    receipt = json['receipt'];
    description = json['description'];
    remark = json['remark'];
    txnId = json['txn_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['retailer_id'] = retailerId;
    data['retailer_user_id'] = retailerUserId;
    data['bank_id'] = bankId;
    data['user_type'] = userType;
    data['payment_for'] = paymentFor;
    data['outstanding_amount'] = outstandingAmount;
    data['request_amount'] = requestAmount;
    data['payment_type'] = paymentType;
    data['bank_name'] = bankName;
    data['ref_number'] = refNumber;
    data['receipt'] = receipt;
    data['description'] = description;
    data['remark'] = remark;
    data['txn_id'] = txnId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
