class RetailerDetailResponseModel {
  bool? success;
  RetailerDetailData? data;
  String? message;
  int? code;

  RetailerDetailResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  RetailerDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? RetailerDetailData.fromJson(json['data'])
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

class RetailerDetailData {
  int? id;
  String? userId;
  String? retailerName;
  String? regMobileNumber;
  String? whatsappNumber;
  String? email;
  String? address;
  String? gstNo;
  String? pincode;
  String? executiveId;
  String? executiveName;
  num? walletBalance;
  num? dueAmount;
  num? registrationCharge;
  num? lowWalletAmount;
  String? packageName;
  String? autoTransfer;
  num? autoTransferAmount;
  String? transaction;
  String? createdAt;
  String? status;
  int? isActive;

  RetailerDetailData({
    this.id,
    this.userId,
    this.retailerName,
    this.regMobileNumber,
    this.whatsappNumber,
    this.email,
    this.address,
    this.gstNo,
    this.pincode,
    this.executiveName,
    this.walletBalance,
    this.dueAmount,
    this.executiveId,
    this.registrationCharge,
    this.lowWalletAmount,
    this.packageName,
    this.autoTransfer,
    this.autoTransferAmount,
    this.transaction,
    this.createdAt,
    this.status,
    this.isActive,
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

  RetailerDetailData.fromJson(Map<String, dynamic> json) {
    id = _parseNum(json['id'])?.toInt();
    userId = _parseString(json['user_id']);
    retailerName = _parseString(json['retailer_name']);
    regMobileNumber = _parseString(json['reg_mobile_number']);
    whatsappNumber = _parseString(json['whatsapp_number']);
    email = _parseString(json['email']);
    address = _parseString(json['address']);
    gstNo = _parseString(json['gst_no']);
    pincode = _parseString(json['pincode']);
    executiveName = _parseString(json['executive_name']);
    walletBalance = _parseNum(json['wallet_balance']);
    dueAmount = _parseNum(json['due_amount']);
    registrationCharge = _parseNum(json['registration_charge']);
    lowWalletAmount = _parseNum(json['low_wallet_amount']);
    packageName = _parseString(json['package_name']);
    autoTransfer = _parseString(json['auto_transfer']);
    autoTransferAmount = _parseNum(json['auto_transfer_amount']);
    transaction = _parseString(json['transaction']);
    createdAt = _parseString(json['created_at']);
    status = _parseString(json['status']);
    isActive = _parseNum(json['is_active'])?.toInt();
    executiveId = _parseString(json['executive_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['address'] = address;
    data['gst_no'] = gstNo;
    data['pincode'] = pincode;
    data['executive_name'] = executiveName;
    data['wallet_balance'] = walletBalance;
    data['due_amount'] = dueAmount;
    data['registration_charge'] = registrationCharge;
    data['low_wallet_amount'] = lowWalletAmount;
    data['package_name'] = packageName;
    data['auto_transfer'] = autoTransfer;
    data['auto_transfer_amount'] = autoTransferAmount;
    data['transaction'] = transaction;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['is_active'] = isActive;
    data['executive_id'] = executiveId;
    return data;
  }
}
