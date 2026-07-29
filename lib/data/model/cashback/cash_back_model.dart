class CashBackModel {
  bool? success;
  CashBackData? data;
  String? message;
  int? code;

  CashBackModel({this.success, this.data, this.message, this.code});

  CashBackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CashBackData.fromJson(json['data']) : null;
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

class CashBackData {
  List<CashBackItem>? list;

  CashBackData({this.list});

  CashBackData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CashBackItem>[];
      json['list'].forEach((v) {
        list!.add(CashBackItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CashBackItem {
  int? productId;
  String? productName;
  String? productLogo;
  String? commissionType;
  double? cashbackValue;
  String? cashbackDisplay;
  int? isNegative;

  CashBackItem({
    this.productId,
    this.productName,
    this.productLogo,
    this.commissionType,
    this.cashbackValue,
    this.cashbackDisplay,
    this.isNegative,
  });

  CashBackItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productLogo = json['product_logo'];
    commissionType = json['commission_type'];
    cashbackValue = (json['cashback_value'] as num?)?.toDouble();
    cashbackDisplay = json['cashback_display'];
    isNegative = json['is_negative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_logo'] = productLogo;
    data['commission_type'] = commissionType;
    data['cashback_value'] = cashbackValue;
    data['cashback_display'] = cashbackDisplay;
    data['is_negative'] = isNegative;
    return data;
  }
}
