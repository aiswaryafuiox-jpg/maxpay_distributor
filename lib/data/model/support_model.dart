class SupportModel {
  bool? success;
  SupportData? data;
  String? message;
  int? code;

  SupportModel({this.success, this.data, this.message, this.code});

  SupportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SupportData.fromJson(json['data']) : null;
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

class SupportData {
  List<SupportContact>? list;

  SupportData({this.list});

  SupportData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SupportContact>[];
      json['list'].forEach((v) {
        list!.add(SupportContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportContact {
  String? title;
  String? phoneNumber;
  String? whatsappNumber;
  String? email;
  int? whatsappEnabled;
  int? callEnabled;
  String? iconUrl;

  SupportContact({
    this.title,
    this.phoneNumber,
    this.whatsappNumber,
    this.email,
    this.whatsappEnabled,
    this.callEnabled,
    this.iconUrl,
  });

  SupportContact.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    whatsappEnabled = json['whatsapp_enabled'];
    callEnabled = json['call_enabled'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['phone_number'] = phoneNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['email'] = email;
    data['whatsapp_enabled'] = whatsappEnabled;
    data['call_enabled'] = callEnabled;
    data['icon_url'] = iconUrl;
    return data;
  }
}
