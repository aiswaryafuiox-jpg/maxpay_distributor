class AddWalletDetailsResponseModel {
  bool? success;
  AddWalletDetailsData? data;
  String? message;
  int? code;

  AddWalletDetailsResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  AddWalletDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? AddWalletDetailsData.fromJson(json['data'])
        : null;
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

class AddWalletDetailsData {
  num? walletBalance;
  int? retailerId;
  String? retailerUserId;
  String? userName;
  num? lastTransferAmount;
  String? lastTransferDateTime;
  num? outstanding;

  // Partner / Distributor fields
  int? distributorId;
  String? distributorUserId;
  String? companyName;
  String? regMobileNumber;

  AddWalletDetailsData({
    this.walletBalance,
    this.retailerId,
    this.retailerUserId,
    this.userName,
    this.lastTransferAmount,
    this.lastTransferDateTime,
    this.outstanding,
    this.distributorId,
    this.distributorUserId,
    this.companyName,
    this.regMobileNumber,
  });

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  AddWalletDetailsData.fromJson(Map<String, dynamic> json) {
    walletBalance = _parseNum(json['wallet_balance']);
    retailerId = _parseNum(
      json['retailer_id'] ?? json['distributor_id'],
    )?.toInt();
    distributorId = _parseNum(json['distributor_id'])?.toInt();
    retailerUserId = _parseString(
      json['retailer_user_id'] ?? json['distributor_user_id'],
    );
    distributorUserId = _parseString(json['distributor_user_id']);
    userName = _parseString(json['user_name'] ?? json['company_name']);
    companyName = _parseString(json['company_name']);
    regMobileNumber = _parseString(json['reg_mobile_number']);
    lastTransferAmount = _parseNum(json['last_transfer_amount']);
    lastTransferDateTime = _parseString(json['last_transfer_date_time']);
    outstanding = _parseNum(json['outstanding']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_balance'] = walletBalance;
    data['retailer_id'] = retailerId;
    data['retailer_user_id'] = retailerUserId;
    data['user_name'] = userName;
    data['last_transfer_amount'] = lastTransferAmount;
    data['last_transfer_date_time'] = lastTransferDateTime;
    data['outstanding'] = outstanding;
    if (distributorId != null) {
      data['distributor_id'] = distributorId;
    }
    if (distributorUserId != null) {
      data['distributor_user_id'] = distributorUserId;
    }
    if (companyName != null) {
      data['company_name'] = companyName;
    }
    if (regMobileNumber != null) {
      data['reg_mobile_number'] = regMobileNumber;
    }
    return data;
  }
}
