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

  RetailerDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    address = json['address'];
    gstNo = json['gst_no'];
    pincode = json['pincode'];
    executiveName = json['executive_name'];
    walletBalance = json['wallet_balance'];
    dueAmount = json['due_amount'];
    registrationCharge = json['registration_charge'];
    lowWalletAmount = json['low_wallet_amount'];
    packageName = json['package_name'];
    autoTransfer = json['auto_transfer'];
    autoTransferAmount = json['auto_transfer_amount'];
    transaction = json['transaction'];
    createdAt = json['created_at'];
    status = json['status'];
    isActive = json['is_active'];
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
    return data;
  }
}
