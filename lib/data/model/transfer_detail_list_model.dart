class TransferDetailListModel {
  bool? success;
  TransferDetailData? data;
  String? message;
  int? code;

  TransferDetailListModel({this.success, this.data, this.message, this.code});

  TransferDetailListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TransferDetailData.fromJson(json['data']) : null;
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

class TransferDetailData {
  String? summaryLabel;
  dynamic summaryAmount;
  List<TransferDetailListItem>? list;

  TransferDetailData({this.summaryLabel, this.summaryAmount, this.list});

  TransferDetailData.fromJson(Map<String, dynamic> json) {
    summaryLabel = json['summary_label'];
    summaryAmount = json['summary_amount'];
    if (json['list'] != null) {
      list = <TransferDetailListItem>[];
      json['list'].forEach((v) {
        list!.add(TransferDetailListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary_label'] = summaryLabel;
    data['summary_amount'] = summaryAmount;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransferDetailListItem {
  int? id;
  String? transactionId;
  String? dateTime;
  String? transactionType;
  String? userType;
  String? userName;
  String? regMobileNumber;
  dynamic amount;
  int? isReversible;

  TransferDetailListItem(
      {this.id,
      this.transactionId,
      this.dateTime,
      this.transactionType,
      this.userType,
      this.userName,
      this.regMobileNumber,
      this.amount,
      this.isReversible});

  TransferDetailListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    dateTime = json['date_time'];
    transactionType = json['transaction_type'];
    userType = json['user_type'];
    userName = json['user_name'];
    regMobileNumber = json['reg_mobile_number'];
    amount = json['amount'];
    isReversible = json['is_reversible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['date_time'] = dateTime;
    data['transaction_type'] = transactionType;
    data['user_type'] = userType;
    data['user_name'] = userName;
    data['reg_mobile_number'] = regMobileNumber;
    data['amount'] = amount;
    data['is_reversible'] = isReversible;
    return data;
  }
}
