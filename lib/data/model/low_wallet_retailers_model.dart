class LowWalletRetailersModel {
  bool? success;
  LowWalletRetailersData? data;
  String? message;
  int? code;

  LowWalletRetailersModel({this.success, this.data, this.message, this.code});

  LowWalletRetailersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? LowWalletRetailersData.fromJson(json['data']) : null;
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

class LowWalletRetailersData {
  int? total;
  List<LowWalletRetailerItem>? list;

  LowWalletRetailersData({this.total, this.list});

  LowWalletRetailersData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <LowWalletRetailerItem>[];
      json['list'].forEach((v) {
        list!.add(LowWalletRetailerItem.fromJson(v));
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

class LowWalletRetailerItem {
  int? id;
  String? userId;
  String? retailerName;
  String? regMobileNumber;
  dynamic walletAmount;
  dynamic lowWallet;
  dynamic transferAmount;
  String? autoTransfer;

  LowWalletRetailerItem(
      {this.id,
      this.userId,
      this.retailerName,
      this.regMobileNumber,
      this.walletAmount,
      this.lowWallet,
      this.transferAmount,
      this.autoTransfer});

  LowWalletRetailerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    walletAmount = json['wallet_amount'];
    lowWallet = json['low_wallet'];
    transferAmount = json['transfer_amount'];
    autoTransfer = json['auto_transfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['wallet_amount'] = walletAmount;
    data['low_wallet'] = lowWallet;
    data['transfer_amount'] = transferAmount;
    data['auto_transfer'] = autoTransfer;
    return data;
  }
}
