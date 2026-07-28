class ExecutiveAddWalletDetailsResponseModel {
  bool? success;
  ExecutiveAddWalletDetailsData? data;
  String? message;
  int? code;

  ExecutiveAddWalletDetailsResponseModel({this.success, this.data, this.message, this.code});

  ExecutiveAddWalletDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ExecutiveAddWalletDetailsData.fromJson(json['data']) : null;
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

class ExecutiveAddWalletDetailsData {
  num? walletBalance;
  int? executiveId;
  String? executiveUserId;
  String? userName;
  num? lastTransferAmount;
  String? lastTransferDateTime;
  num? outstanding;

  ExecutiveAddWalletDetailsData({
    this.walletBalance,
    this.executiveId,
    this.executiveUserId,
    this.userName,
    this.lastTransferAmount,
    this.lastTransferDateTime,
    this.outstanding,
  });

  ExecutiveAddWalletDetailsData.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
    executiveId = json['executive_id'];
    executiveUserId = json['executive_user_id'];
    userName = json['user_name'];
    lastTransferAmount = json['last_transfer_amount'];
    lastTransferDateTime = json['last_transfer_date_time'];
    outstanding = json['outstanding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_balance'] = walletBalance;
    data['executive_id'] = executiveId;
    data['executive_user_id'] = executiveUserId;
    data['user_name'] = userName;
    data['last_transfer_amount'] = lastTransferAmount;
    data['last_transfer_date_time'] = lastTransferDateTime;
    data['outstanding'] = outstanding;
    return data;
  }
}
