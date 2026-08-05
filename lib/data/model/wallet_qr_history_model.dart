// To parse this JSON data, do
//
//     final walletQrHistoryModel = walletQrHistoryModelFromJson(jsonString);

import 'dart:convert';

WalletQrHistoryModel walletQrHistoryModelFromJson(String str) =>
    WalletQrHistoryModel.fromJson(json.decode(str));

String walletQrHistoryModelToJson(WalletQrHistoryModel data) =>
    json.encode(data.toJson());

class WalletQrHistoryModel {
  bool? success;
  WalletQrHistory? data;
  String? message;
  int? code;

  WalletQrHistoryModel({this.success, this.data, this.message, this.code});

  factory WalletQrHistoryModel.fromJson(Map<String, dynamic> json) =>
      WalletQrHistoryModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : WalletQrHistory.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class WalletQrHistory {
  List<WalletQrHistoryData>? list;

  WalletQrHistory({this.list});

  factory WalletQrHistory.fromJson(Map<String, dynamic> json) =>
      WalletQrHistory(
        list: json["list"] == null
            ? []
            : List<WalletQrHistoryData>.from(
                json["list"]!.map((x) => WalletQrHistoryData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "list": list == null
        ? []
        : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class WalletQrHistoryData {
  int? id;
  String? utrNo;
  String? transactionId;
  String? dateTime;
  String? status;
  String? paymentStatus;
  String? paymentMode;
  String? transactionType;
  String? amountType;
  int? amount;
  String? remark;
  String? transferBy;

  WalletQrHistoryData({
    this.id,
    this.utrNo,
    this.transactionId,
    this.dateTime,
    this.status,
    this.paymentStatus,
    this.paymentMode,
    this.transactionType,
    this.amountType,
    this.amount,
    this.remark,
    this.transferBy,
  });

  factory WalletQrHistoryData.fromJson(Map<String, dynamic> json) =>
      WalletQrHistoryData(
        id: json["id"],
        utrNo: json["utr_no"],
        transactionId: json["transaction_id"],
        dateTime: json["date_time"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        paymentMode: json["payment_mode"],
        transactionType: json["transaction_type"],
        amountType: json["amount_type"],
        amount: json["amount"],
        remark: json["remark"],
        transferBy: json["transfer_by"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "utr_no": utrNo,
    "transaction_id": transactionId,
    "date_time": dateTime,
    "status": status,
    "payment_status": paymentStatus,
    "payment_mode": paymentMode,
    "transaction_type": transactionType,
    "amount_type": amountType,
    "amount": amount,
    "remark": remark,
    "transfer_by": transferBy,
  };
}
