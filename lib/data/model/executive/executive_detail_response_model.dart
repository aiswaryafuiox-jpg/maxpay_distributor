class ExecutiveDetailResponseModel {
  bool? success;
  ExecutiveDetailData? data;
  String? message;
  int? code;

  ExecutiveDetailResponseModel({this.success, this.data, this.message, this.code});

  ExecutiveDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ExecutiveDetailData.fromJson(json['data']) : null;
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

class ExecutiveDetailData {
  int? id;
  String? userId;
  String? executiveName;
  String? regMobileNumber;
  String? whatsappNumber;
  String? email;
  String? address;
  String? pinCode;
  num? walletBalance;
  num? dueAmount;
  String? commissionPackage;
  String? autoTransfer;
  String? createdOnTime;
  String? status;
  num? minimumAmount;
  num? autoTransferAmount;

  ExecutiveDetailData({
    this.id,
    this.userId,
    this.executiveName,
    this.regMobileNumber,
    this.whatsappNumber,
    this.email,
    this.address,
    this.pinCode,
    this.walletBalance,
    this.dueAmount,
    this.commissionPackage,
    this.autoTransfer,
    this.createdOnTime,
    this.status,
    this.minimumAmount,
    this.autoTransferAmount,
  });

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  ExecutiveDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    userId = json['user_id']?.toString();
    executiveName = json['executive_name']?.toString();
    regMobileNumber = json['reg_mobile_number']?.toString();
    whatsappNumber = json['whatsapp_number']?.toString();
    email = json['email']?.toString();
    address = json['address']?.toString();
    pinCode = json['pin_code']?.toString();
    walletBalance = _parseNum(
      json['wallet_balance'] ??
          json['wallet_amount'] ??
          json['wallet'] ??
          json['balance'],
    );
    dueAmount = _parseNum(json['due_amount']);
    commissionPackage = json['commission_package']?.toString();
    autoTransfer = json['auto_transfer']?.toString();
    createdOnTime = json['created_on_time']?.toString();
    status = json['status']?.toString();
    minimumAmount = _parseNum(json['minimum_amount']);
    autoTransferAmount = _parseNum(json['auto_transfer_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['executive_name'] = executiveName;
    data['reg_mobile_number'] = regMobileNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['address'] = address;
    data['pin_code'] = pinCode;
    data['wallet_balance'] = walletBalance;
    data['due_amount'] = dueAmount;
    data['commission_package'] = commissionPackage;
    data['auto_transfer'] = autoTransfer;
    data['created_on_time'] = createdOnTime;
    data['status'] = status;
    data['minimum_amount'] = minimumAmount;
    data['auto_transfer_amount'] = autoTransferAmount;
    return data;
  }
}
