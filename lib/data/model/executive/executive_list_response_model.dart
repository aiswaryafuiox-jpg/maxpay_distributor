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
  int? isActive;
  // Note: Add other properties if they exist in the actual response payload

  Executive({
    this.id,
    this.executiveName,
    this.regMobileNumber,
    this.dueAmount,
    this.walletBalance,
    this.isActive,
  });

  Executive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    executiveName = json['executive_name'];
    regMobileNumber = json['reg_mobile_number'];
    dueAmount = json['due_amount'];
    walletBalance = json['wallet_balance'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['executive_name'] = executiveName;
    data['reg_mobile_number'] = regMobileNumber;
    data['due_amount'] = dueAmount;
    data['wallet_balance'] = walletBalance;
    data['is_active'] = isActive;
    return data;
  }
}
