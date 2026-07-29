class TransactionReportResponseModel {
  final bool? success;
  final TransactionReportData? data;
  final String? message;
  final int? code;

  TransactionReportResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory TransactionReportResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionReportResponseModel(
      success: json['success'],
      data: json['data'] != null ? TransactionReportData.fromJson(json['data']) : null,
      message: json['message'],
      code: json['code'],
    );
  }
}

class TransactionReportData {
  final int? totalTransaction;
  final List<TransactionReportItem>? list;

  TransactionReportData({
    this.totalTransaction,
    this.list,
  });

  factory TransactionReportData.fromJson(Map<String, dynamic> json) {
    return TransactionReportData(
      totalTransaction: json['total_transaction'],
      list: json['list'] != null
          ? List<TransactionReportItem>.from(json['list'].map((x) => TransactionReportItem.fromJson(x)))
          : null,
    );
  }
}

class TransactionReportItem {
  final int? id;
  final String? transactionId;
  final String? dateTime;
  final String? productName;
  final String? productLogo;
  final String? mobile;
  final String? mobileFull;
  final num? amount;
  final String? status;
  final int? canDispute;

  TransactionReportItem({
    this.id,
    this.transactionId,
    this.dateTime,
    this.productName,
    this.productLogo,
    this.mobile,
    this.mobileFull,
    this.amount,
    this.status,
    this.canDispute,
  });

  factory TransactionReportItem.fromJson(Map<String, dynamic> json) {
    return TransactionReportItem(
      id: json['id'],
      transactionId: json['transaction_id'],
      dateTime: json['date_time'],
      productName: json['product_name'],
      productLogo: json['product_logo'],
      mobile: json['mobile'],
      mobileFull: json['mobile_full'],
      amount: json['amount'],
      status: json['status'],
      canDispute: json['can_dispute'],
    );
  }
}
