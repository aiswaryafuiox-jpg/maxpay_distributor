class StatementDescriptionsModel {
  bool? success;
  List<StatementDescriptionData>? data;
  String? message;
  int? code;

  StatementDescriptionsModel({this.success, this.data, this.message, this.code});

  StatementDescriptionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StatementDescriptionData>[];
      json['data'].forEach((v) {
        data!.add(StatementDescriptionData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}

class StatementDescriptionData {
  int? id;
  String? name;
  String? value;

  StatementDescriptionData({this.id, this.name, this.value});

  StatementDescriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    return map;
  }
}
