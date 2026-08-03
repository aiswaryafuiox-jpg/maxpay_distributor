class WalletQrHistory {
  bool? success;
  List<WalletQrHistoryData>? data;
  String? message;
  int? code;

  WalletQrHistory({this.success, this.data, this.message, this.code});

  WalletQrHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data']['list'] != null &&
        (json['data']['list'] as List).isNotEmpty) {
      data = <WalletQrHistoryData>[];
      json['data']['list'].forEach((v) {
        data!.add(WalletQrHistoryData.fromJson(v));
      });
    } else {
      data = [];
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
      'message': message,
      'code': code,
    };
  }
}

class WalletQrHistoryData {
  String? txnId;
  String? amount;
  String? status;
  String? dateTime;

  WalletQrHistoryData({this.txnId, this.amount, this.status, this.dateTime});

  WalletQrHistoryData.fromJson(Map<String, dynamic> json) {
    txnId = json['txn_id']?.toString() ?? json['transaction_id']?.toString();
    amount = json['amount']?.toString();
    status = json['status']?.toString();
    dateTime = json['created_at']?.toString() ?? json['date']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'txn_id': txnId,
      'amount': amount,
      'status': status,
      'created_at': dateTime,
    };
  }
}
