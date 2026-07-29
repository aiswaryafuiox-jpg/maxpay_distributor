class KycModel {
  bool? success;
  KycData? data;
  String? message;
  int? code;

  KycModel({this.success, this.data, this.message, this.code});

  KycModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? KycData.fromJson(json['data']) : null;
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

class KycData {
  String? email;
  String? whatsappNumber;
  int? kycSubmitted;

  KycData({this.email, this.whatsappNumber, this.kycSubmitted});

  KycData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    kycSubmitted = json['kyc_submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['whatsapp_number'] = whatsappNumber;
    data['kyc_submitted'] = kycSubmitted;
    return data;
  }
}
