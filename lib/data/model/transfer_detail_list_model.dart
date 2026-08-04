// To parse this JSON data, do
//
//     final transferDetailListModel = transferDetailListModelFromJson(jsonString);

import 'dart:convert';

TransferDetailListModel transferDetailListModelFromJson(String str) =>
    TransferDetailListModel.fromJson(json.decode(str));

String transferDetailListModelToJson(TransferDetailListModel data) =>
    json.encode(data.toJson());

class TransferDetailListModel {
  bool? success;
  TransferDetailListData? data;
  String? message;
  int? code;

  TransferDetailListModel({this.success, this.data, this.message, this.code});

  factory TransferDetailListModel.fromJson(Map<String, dynamic> json) =>
      TransferDetailListModel(
        success: json["success"],
        data: json["data"] == null ? null : TransferDetailListData.fromJson(json["data"]),
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

class TransferDetailListData {
  String? summaryLabel;
  int? summaryAmount;
  List<TransferDetailListItem>? list;

  TransferDetailListData({this.summaryLabel, this.summaryAmount, this.list});

  factory TransferDetailListData.fromJson(Map<String, dynamic> json) =>
      TransferDetailListData(
        summaryLabel: json["summary_label"],
        summaryAmount: json["summary_amount"],
        list: json["list"] == null
            ? []
            : List<TransferDetailListItem>.from(
                json["list"]!.map((x) => TransferDetailListItem.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "summary_label": summaryLabel,
    "summary_amount": summaryAmount,
    "list": list == null
        ? []
        : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class TransferDetailListItem {
  int? id;
  String? transactionId;
  String? dateTime;
  String? transactionType;
  String? userType;
  String? userName;
  String? regMobileNumber;
  int? amount;
  int? isReversible;

  TransferDetailListItem({
    this.id,
    this.transactionId,
    this.dateTime,
    this.transactionType,
    this.userType,
    this.userName,
    this.regMobileNumber,
    this.amount,
    this.isReversible,
  });

  factory TransferDetailListItem.fromJson(Map<String, dynamic> json) =>
      TransferDetailListItem(
        id: json["id"],
        transactionId: json["transaction_id"],
        dateTime: json["date_time"],
        transactionType: json["transaction_type"],
        userType: json["user_type"],
        userName: json["user_name"],
        regMobileNumber: json["reg_mobile_number"],
        amount: json["amount"],
        isReversible: json["is_reversible"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "date_time": dateTime,
    "transaction_type": transactionType,
    "user_type": userType,
    "user_name": userName,
    "reg_mobile_number": regMobileNumber,
    "amount": amount,
    "is_reversible": isReversible,
  };
}
