class PayoutModel {
  bool? success;
  PayoutData? data;
  String? message;
  int? code;

  PayoutModel({this.success, this.data, this.message, this.code});

  PayoutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? PayoutData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
        'code': code,
      };
}

class PayoutData {
  String? userType;
  String? todayTotalEarnings;
  String? totalEarnings;
  List<PayoutItem>? list;

  PayoutData({
    this.userType,
    this.todayTotalEarnings,
    this.totalEarnings,
    this.list,
  });

  PayoutData.fromJson(Map<String, dynamic> json) {
    userType = json['user_type']?.toString();
    todayTotalEarnings = json['today_total_earnings']?.toString();
    totalEarnings = json['total_earnings']?.toString();
    if (json['list'] != null) {
      list = (json['list'] as List)
          .map((v) => PayoutItem.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'user_type': userType,
        'today_total_earnings': todayTotalEarnings,
        'total_earnings': totalEarnings,
        'list': list?.map((v) => v.toJson()).toList(),
      };
}

class PayoutItem {
  int? id;
  String? transactionNo;
  String? dateTime;
  String? retailerName;
  String? productName;
  String? productType;
  String? productLogo;
  String? transactionAmount;
  String? myEarnings;
  String? commissionValue;
  String? mobileNumber;
  String? status;

  PayoutItem({
    this.id,
    this.transactionNo,
    this.dateTime,
    this.retailerName,
    this.productName,
    this.productType,
    this.productLogo,
    this.transactionAmount,
    this.myEarnings,
    this.commissionValue,
    this.mobileNumber,
    this.status,
  });

  PayoutItem.fromJson(Map<String, dynamic> json) {
    id = json['recharge_id'] is int
        ? json['recharge_id']
        : int.tryParse('${json['recharge_id']}');
    transactionNo = json['recharge_id']?.toString();
    dateTime = json['recharge_date']?.toString();
    retailerName = json['retailer_name']?.toString();
    productName = json['product_name']?.toString();
    productType = json['product_type']?.toString();
    productLogo = json['product_logo']?.toString();
    transactionAmount = json['recharge_amount']?.toString();
    myEarnings = json['commission_amount']?.toString();
    commissionValue = json['commission_value']?.toString();
    mobileNumber = json['mobile']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() => {
        'recharge_id': id,
        'recharge_date': dateTime,
        'retailer_name': retailerName,
        'product_name': productName,
        'product_type': productType,
        'product_logo': productLogo,
        'recharge_amount': transactionAmount,
        'commission_amount': myEarnings,
        'commission_value': commissionValue,
        'mobile': mobileNumber,
        'status': status,
      };
}