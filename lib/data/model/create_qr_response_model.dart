class CreateQrResponseModel {
  bool? success;
  CreateQrData? data;
  String? message;
  int? code;

  String? get txnId => data?.txnId;
  String? get upiLink => data?.upiLink;

  CreateQrResponseModel({this.success, this.data, this.message, this.code});

  CreateQrResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CreateQrData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
  
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class CreateQrData {
  String? txnId;
  String? upiLink;

  CreateQrData({this.txnId, this.upiLink});

  CreateQrData.fromJson(Map<String, dynamic> json) {
    txnId = json['txn_id']?.toString();
    upiLink = json['upi_link']?.toString() ?? json['upiLink']?.toString() ?? json['url']?.toString();
  }
  
  Map<String, dynamic> toJson() {
    return {
      'txn_id': txnId,
      'upi_link': upiLink,
    };
  }
}
