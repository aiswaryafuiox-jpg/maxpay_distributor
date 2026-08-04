class ExecutiveListResponseModel {
  bool? success;
  ExecutiveData? data;
  String? message;
  int? code;

  ExecutiveListResponseModel({this.success, this.data, this.message, this.code});

  ExecutiveListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ExecutiveData.fromJson(json['data']) : null;
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

class ExecutiveData {
  int? totalExecutive;
  List<Executive>? list;

  ExecutiveData({this.totalExecutive, this.list});

  ExecutiveData.fromJson(Map<String, dynamic> json) {
    totalExecutive = json['total_executive'];
    if (json['list'] != null) {
      list = <Executive>[];
      json['list'].forEach((v) {
        list!.add(Executive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_executive'] = totalExecutive;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Executive {
  int? id;
  String? executiveName;
  String? regMobileNumber;
  num? dueAmount;
  num? walletBalance;
  num? walletAmount;
  int? isActive;
  // Note: Add other properties if they exist in the actual response payload

  Executive({
    this.id,
    this.executiveName,
    this.regMobileNumber,
    this.dueAmount,
    this.walletBalance,
    this.walletAmount,
    this.isActive,
  });

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  Executive.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    executiveName = json['executive_name']?.toString();
    regMobileNumber = json['reg_mobile_number']?.toString();
    dueAmount = _parseNum(json['due_amount']);
    walletBalance = _parseNum(
      json['wallet_balance'] ??
          json['wallet_amount'] ??
          json['wallet'] ??
          json['balance'],
    );
    walletAmount = _parseNum(
      json['wallet_amount'] ??
          json['wallet_balance'] ??
          json['wallet'] ??
          json['balance'],
    );
    isActive = json['is_active'] is int
        ? json['is_active']
        : int.tryParse(json['is_active']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['executive_name'] = executiveName;
    data['reg_mobile_number'] = regMobileNumber;
    data['due_amount'] = dueAmount;
    data['wallet_balance'] = walletBalance;
    data['wallet_amount'] = walletAmount;
    data['is_active'] = isActive;
    return data;
  }
}
