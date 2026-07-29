class StatementListModel {
  bool? success;
  StatementData? data;
  String? message;
  int? code;

  StatementListModel({this.success, this.data, this.message, this.code});

  StatementListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? StatementData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}

class StatementData {
  List<StatementItem>? list;

  StatementData({this.list});

  StatementData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <StatementItem>[];
      json['list'].forEach((v) {
        list!.add(StatementItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StatementItem {
  String? id;
  String? dateTime;
  String? description;
  String? product;
  String? transactionId;
  String? transactionNo;
  String? openingBalance;
  String? credit;
  String? debit;
  String? closingBalance;

  StatementItem({
    this.id,
    this.dateTime,
    this.description,
    this.product,
    this.transactionId,
    this.transactionNo,
    this.openingBalance,
    this.credit,
    this.debit,
    this.closingBalance,
  });

  StatementItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    dateTime = json['date_time']?.toString() ?? json['created_at']?.toString();
    description = json['description']?.toString();
    product = json['product']?.toString();
    transactionId = json['transaction_id']?.toString();
    transactionNo = json['transaction_no']?.toString();
    openingBalance = json['opening_balance']?.toString();
    credit = json['credit']?.toString();
    debit = json['debit']?.toString();
    closingBalance = json['closing_balance']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['date_time'] = dateTime;
    map['description'] = description;
    map['product'] = product;
    map['transaction_id'] = transactionId;
    map['transaction_no'] = transactionNo;
    map['opening_balance'] = openingBalance;
    map['credit'] = credit;
    map['debit'] = debit;
    map['closing_balance'] = closingBalance;
    return map;
  }
}
