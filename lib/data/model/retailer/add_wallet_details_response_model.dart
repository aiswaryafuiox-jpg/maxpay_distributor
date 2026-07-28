class AddWalletDetailsResponseModel {
  bool? success;
  AddWalletDetailsData? data;
  String? message;
  int? code;

  AddWalletDetailsResponseModel({this.success, this.data, this.message, this.code});

  AddWalletDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AddWalletDetailsData.fromJson(json['data']) : null;
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

class AddWalletDetailsData {
  num? walletBalance;
  int? retailerId;
  String? retailerUserId;
  String? userName;
  num? lastTransferAmount;
  String? lastTransferDateTime;
  num? outstanding;

  AddWalletDetailsData({
    this.walletBalance,
    this.retailerId,
    this.retailerUserId,
    this.userName,
    this.lastTransferAmount,
    this.lastTransferDateTime,
    this.outstanding,
  });

  AddWalletDetailsData.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
    retailerId = json['retailer_id'];
    retailerUserId = json['retailer_user_id'];
    userName = json['user_name'];
    lastTransferAmount = json['last_transfer_amount'];
    lastTransferDateTime = json['last_transfer_date_time'];
    outstanding = json['outstanding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_balance'] = walletBalance;
    data['retailer_id'] = retailerId;
    data['retailer_user_id'] = retailerUserId;
    data['user_name'] = userName;
    data['last_transfer_amount'] = lastTransferAmount;
    data['last_transfer_date_time'] = lastTransferDateTime;
    data['outstanding'] = outstanding;
    return data;
  }
}
