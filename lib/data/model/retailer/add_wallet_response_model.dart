class AddWalletResponseModel {
  bool? success;
  AddWalletData? data;
  String? message;
  int? code;

  AddWalletResponseModel({this.success, this.data, this.message, this.code});

  AddWalletResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AddWalletData.fromJson(json['data']) : null;
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

class AddWalletData {
  String? transactionId;
  num? amount;
  int? retailerId;
  String? retailerUserId;
  String? userName;
  num? walletBalance;
  num? retailerBalance;
  num? outstanding;
  int? transferId;

  AddWalletData({
    this.transactionId,
    this.amount,
    this.retailerId,
    this.retailerUserId,
    this.userName,
    this.walletBalance,
    this.retailerBalance,
    this.outstanding,
    this.transferId,
  });

  AddWalletData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    amount = json['amount'];
    retailerId = json['retailer_id'];
    retailerUserId = json['retailer_user_id'];
    userName = json['user_name'];
    walletBalance = json['wallet_balance'];
    retailerBalance = json['retailer_balance'];
    outstanding = json['outstanding'];
    transferId = json['transfer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['retailer_id'] = retailerId;
    data['retailer_user_id'] = retailerUserId;
    data['user_name'] = userName;
    data['wallet_balance'] = walletBalance;
    data['retailer_balance'] = retailerBalance;
    data['outstanding'] = outstanding;
    data['transfer_id'] = transferId;
    return data;
  }
}
