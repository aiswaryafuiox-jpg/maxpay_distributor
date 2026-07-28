class WalletCreditListModel {
  bool? success;
  WalletCreditListData? data;
  String? message;
  int? code;

  WalletCreditListModel({this.success, this.data, this.message, this.code});

  WalletCreditListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? WalletCreditListData.fromJson(json['data']) : null;
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

class WalletCreditListData {
  String? creditAmount;
  List<WalletCreditItem>? list;

  WalletCreditListData({this.creditAmount, this.list});

  WalletCreditListData.fromJson(Map<String, dynamic> json) {
    creditAmount = json['credit_amount']?.toString();
    if (json['list'] != null) {
      list = <WalletCreditItem>[];
      json['list'].forEach((v) {
        list!.add(WalletCreditItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit_amount'] = creditAmount;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletCreditItem {
  String? transactionId;
  String? dateTime;
  String? creditType;
  String? amount;

  WalletCreditItem({this.transactionId, this.dateTime, this.creditType, this.amount});

  WalletCreditItem.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    dateTime = json['date_time'];
    creditType = json['credit_type']?.toString();
    amount = json['amount']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['date_time'] = dateTime;
    data['credit_type'] = creditType;
    data['amount'] = amount;
    return data;
  }
}
