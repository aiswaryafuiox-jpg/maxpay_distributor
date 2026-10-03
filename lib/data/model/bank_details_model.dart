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
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = bankName;
    data['account_type'] = accountType;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['branch'] = branch;
    data['upi_id'] = upiId;
    data['qr_code'] = qrCode;
    data['bank_logo'] = bankLogo;
    data['description'] = description;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
