class LoginHistoryModel {
  bool? success;
  LoginHistoryData? data;
  String? message;
  int? code;

  LoginHistoryModel({this.success, this.data, this.message, this.code});

  LoginHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? LoginHistoryData.fromJson(json['data']) : null;
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

class LoginHistoryData {
  List<LoginHistoryItem>? list;

  LoginHistoryData({this.list});

  LoginHistoryData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <LoginHistoryItem>[];
      json['list'].forEach((v) {
        list!.add(LoginHistoryItem.fromJson(v));
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

class LoginHistoryItem {
  int? id;
  String? location;
  String? dateTime;
  String? loginTime;
  String? logoutTime;
  String? network;
  String? ipAddress;

  LoginHistoryItem({
    this.id,
    this.location,
    this.dateTime,
    this.loginTime,
    this.logoutTime,
    this.network,
    this.ipAddress,
  });

  LoginHistoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    dateTime = json['date_time'];
    loginTime = json['login_time'];
    logoutTime = json['logout_time'];
    network = json['network'];
    ipAddress = json['ip_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    data['date_time'] = dateTime;
    data['login_time'] = loginTime;
    data['logout_time'] = logoutTime;
    data['network'] = network;
    data['ip_address'] = ipAddress;
    return data;
  }
}
