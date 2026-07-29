class OutstandingListModel {
  bool? success;
  OutstandingListData? data;
  String? message;
  int? code;

  OutstandingListModel({this.success, this.data, this.message, this.code});

  OutstandingListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? OutstandingListData.fromJson(json['data']) : null;
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

class OutstandingListData {
  int? total;
  List<OutstandingItem>? list;

  OutstandingListData({this.total, this.list});

  OutstandingListData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <OutstandingItem>[];
      json['list'].forEach((v) {
        list!.add(OutstandingItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutstandingItem {
  int? id;
  String? retailerName;
  String? regMobileNumber;
  dynamic outstandingAmount;
  String? date;

  OutstandingItem(
      {this.id,
      this.retailerName,
      this.regMobileNumber,
      this.outstandingAmount,
      this.date});

  OutstandingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerName = json['retailer_name'];
    regMobileNumber = json['reg_mobile_number'];
    outstandingAmount = json['outstanding_amount'] ?? json['outstanding'];
    date = json['date_time'] ?? json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['retailer_name'] = retailerName;
    data['reg_mobile_number'] = regMobileNumber;
    data['outstanding_amount'] = outstandingAmount;
    data['date_time'] = date;
    return data;
  }
}
