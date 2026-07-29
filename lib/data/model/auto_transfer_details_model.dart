class AutoTransferDetailsModel {
  bool? success;
  AutoTransferData? data;
  String? message;
  int? code;

  AutoTransferDetailsModel({this.success, this.data, this.message, this.code});

  AutoTransferDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AutoTransferData.fromJson(json['data']) : null;
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

class AutoTransferData {
  int? id;
  String? userId;
  String? retailerName;
  String? walletAmount;
  String? lowWallet;
  String? transferAmount;
  String? autoTransfer;

  AutoTransferData({
    this.id,
    this.userId,
    this.retailerName,
    this.walletAmount,
    this.lowWallet,
    this.transferAmount,
    this.autoTransfer,
  });

  AutoTransferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    walletAmount = json['wallet_amount']?.toString();
    lowWallet = json['low_wallet']?.toString();
    transferAmount = json['transfer_amount']?.toString();
    autoTransfer = json['auto_transfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['wallet_amount'] = walletAmount;
    data['low_wallet'] = lowWallet;
    data['transfer_amount'] = transferAmount;
    data['auto_transfer'] = autoTransfer;
    return data;
  }
}
