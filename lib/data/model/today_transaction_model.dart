class TodayTransactionModel {
  bool? success;
  TodayTransactionData? data;
  String? message;
  int? code;

  TodayTransactionModel({this.success, this.data, this.message, this.code});

  TodayTransactionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TodayTransactionData.fromJson(json['data']) : null;
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

class TodayTransactionData {
  TransactionSummary? todaysCredit;
  TransactionSummary? todaysTransfer;
  TransactionSummary? todaysReverse;

  TodayTransactionData({this.todaysCredit, this.todaysTransfer, this.todaysReverse});

  TodayTransactionData.fromJson(Map<String, dynamic> json) {
    todaysCredit = json['todays_credit'] != null
        ? TransactionSummary.fromJson(json['todays_credit'])
        : null;
    todaysTransfer = json['todays_transfer'] != null
        ? TransactionSummary.fromJson(json['todays_transfer'])
        : null;
    todaysReverse = json['todays_reverse'] != null
        ? TransactionSummary.fromJson(json['todays_reverse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (todaysCredit != null) {
      data['todays_credit'] = todaysCredit!.toJson();
    }
    if (todaysTransfer != null) {
      data['todays_transfer'] = todaysTransfer!.toJson();
    }
    if (todaysReverse != null) {
      data['todays_reverse'] = todaysReverse!.toJson();
    }
    return data;
  }
}

class TransactionSummary {
  num? amount;
  num? count;

  TransactionSummary({this.amount, this.count});

  TransactionSummary.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['count'] = count;
    return data;
  }
}
