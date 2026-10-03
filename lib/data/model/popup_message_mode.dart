class PopupMessage {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  PopupMessage({this.success, this.data, this.message, this.code});

  PopupMessage.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? noOfMsg;
  String? businessType;
  String? userType;
  String? liveFromDate;
  String? liveToDate;
  String? screenType;
  String? message;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.title,
    this.noOfMsg,
    this.businessType,
    this.userType,
    this.liveFromDate,
    this.liveToDate,
    this.screenType,
    this.message,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    noOfMsg = json['no_of_msg'];
    businessType = json['business_type'];
    userType = json['user_type'];
    liveFromDate = json['live_from_date'];
    liveToDate = json['live_to_date'];
    screenType = json['screen_type'];
    message = json['message'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['no_of_msg'] = noOfMsg;
    data['business_type'] = businessType;
    data['user_type'] = userType;
    data['live_from_date'] = liveFromDate;
    data['live_to_date'] = liveToDate;
    data['screen_type'] = screenType;
    data['message'] = message;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
