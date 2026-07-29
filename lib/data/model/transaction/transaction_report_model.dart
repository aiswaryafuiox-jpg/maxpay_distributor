class TransactionReportModel {
  bool? success;
  TransactionReportData? data;
  String? message;
  int? code;

  TransactionReportModel({this.success, this.data, this.message, this.code});

  TransactionReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? TransactionReportData.fromJson(json['data']) : null;
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

class TransactionReportData {
  String? totalTransaction;
  String? totalProfit;
  List<TransactionItem>? list;

  TransactionReportData({this.totalTransaction, this.totalProfit, this.list});

  TransactionReportData.fromJson(Map<String, dynamic> json) {
    totalTransaction = json['total_transaction']?.toString();
    totalProfit = json['total_profit']?.toString();
    if (json['list'] != null) {
      list = <TransactionItem>[];
      json['list'].forEach((v) {
        list!.add(TransactionItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_transaction'] = totalTransaction;
    data['total_profit'] = totalProfit;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionItem {
  int? id;
  String? transactionNo;
  String? dateTime;
  String? productName;
  String? productType;
  String? productLogo;
  String? amount;
  String? packageName;
  int? hasExecutive;
  Commission? commission;

  TransactionItem({
    this.id,
    this.transactionNo,
    this.dateTime,
    this.productName,
    this.productType,
    this.productLogo,
    this.amount,
    this.packageName,
    this.hasExecutive,
    this.commission,
  });

  TransactionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionNo = json['transaction_no']?.toString();
    dateTime = json['date_time']?.toString();
    productName = json['product_name']?.toString();
    productType = json['product_type']?.toString();
    productLogo = json['product_logo']?.toString();
    amount = json['amount']?.toString();
    packageName = json['package_name']?.toString();
    hasExecutive = json['has_executive'];
    commission = json['commission'] != null ? Commission.fromJson(json['commission']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_no'] = transactionNo;
    data['date_time'] = dateTime;
    data['product_name'] = productName;
    data['product_type'] = productType;
    data['product_logo'] = productLogo;
    data['amount'] = amount;
    data['package_name'] = packageName;
    data['has_executive'] = hasExecutive;
    if (commission != null) {
      data['commission'] = commission!.toJson();
    }
    return data;
  }
}

class Commission {
  String? credit;
  String? debit;
  String? profit;

  Commission({this.credit, this.debit, this.profit});

  Commission.fromJson(Map<String, dynamic> json) {
    credit = json['credit']?.toString();
    debit = json['debit']?.toString();
    profit = json['profit']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit'] = credit;
    data['debit'] = debit;
    data['profit'] = profit;
    return data;
  }
}