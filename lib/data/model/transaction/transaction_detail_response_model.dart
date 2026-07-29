class TransactionDetailResponseModel {
  final bool? success;
  final TransactionDetailData? data;
  final String? message;
  final int? code;

  TransactionDetailResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory TransactionDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailResponseModel(
      success: json['success'],
      data: json['data'] != null ? TransactionDetailData.fromJson(json['data']) : null,
      message: json['message'],
      code: json['code'],
    );
  }
}

class TransactionDetailData {
  final int? id;
  final String? transactionId;
  final String? dateTime;
  final String? productName;
  final String? productLogo;
  final String? mobile;
  final num? amount;
  final String? status;
  final String? retailerName;
  final int? canDispute;

  TransactionDetailData({
    this.id,
    this.transactionId,
    this.dateTime,
    this.productName,
    this.productLogo,
    this.mobile,
    this.amount,
    this.status,
    this.retailerName,
    this.canDispute,
  });

  factory TransactionDetailData.fromJson(Map<String, dynamic> json) {
    return TransactionDetailData(
      id: json['id'],
      transactionId: json['transaction_id'],
      dateTime: json['date_time'],
      productName: json['product_name'],
      productLogo: json['product_logo'],
      mobile: json['mobile'],
      amount: json['amount'],
      status: json['status'],
      retailerName: json['retailer_name'],
      canDispute: json['can_dispute'],
    );
  }
}
