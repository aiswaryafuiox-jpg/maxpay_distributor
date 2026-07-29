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

  ExecutiveDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    executiveName = json['executive_name'];
    regMobileNumber = json['reg_mobile_number'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    address = json['address'];
    pinCode = json['pin_code'];
    walletBalance = json['wallet_balance'];
    dueAmount = json['due_amount'];
    commissionPackage = json['commission_package'];
    autoTransfer = json['auto_transfer'];
    createdOnTime = json['created_on_time'];
    status = json['status'];
    minimumAmount = json['minimum_amount'];
    autoTransferAmount = json['auto_transfer_amount'];
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
