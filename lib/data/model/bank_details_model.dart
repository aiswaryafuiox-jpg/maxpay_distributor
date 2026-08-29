class BankDetails {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  BankDetails({this.success, this.data, this.message, this.code});

  BankDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? id;
  String? bankName;
  String? accountType;
  String? accountName;
  String? accountNumber;
  String? ifscCode;
  String? branch;
  String? upiId;
  String? qrCode;
  String? bankLogo;
  String? description;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.bankName,
      this.accountType,
      this.accountName,
      this.accountNumber,
      this.ifscCode,
      this.branch,
      this.upiId,
      this.qrCode,
      this.bankLogo,
      this.description,
      this.amount,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    accountType = json['account_type'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    branch = json['branch'];
    upiId = json['upi_id'];
    qrCode = json['qr_code'];
    bankLogo = json['bank_logo'];
    description = json['description'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['account_type'] = this.accountType;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['branch'] = this.branch;
    data['upi_id'] = this.upiId;
    data['qr_code'] = this.qrCode;
    data['bank_logo'] = this.bankLogo;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
