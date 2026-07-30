class AddWalletBalanceModel {
  bool? success;
  AddWalletBalanceData? data;
  String? message;
  int? code;

  AddWalletBalanceModel({this.success, this.data, this.message, this.code});

  AddWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? AddWalletBalanceData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class AddWalletBalanceData {
  String? walletBalance;

  AddWalletBalanceData({this.walletBalance});

  AddWalletBalanceData.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance']?.toString() ?? json['balance']?.toString();
  }
}
