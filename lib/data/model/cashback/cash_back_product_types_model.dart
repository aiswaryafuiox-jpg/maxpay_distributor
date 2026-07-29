class CashBackProductTypesModel {
  bool? success;
  List<CashBackProductType>? data;
  String? message;
  int? code;

  CashBackProductTypesModel({this.success, this.data, this.message, this.code});

  CashBackProductTypesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CashBackProductType>[];
      json['data'].forEach((v) {
        data!.add(CashBackProductType.fromJson(v));
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

class CashBackProductType {
  int? id;
  String? name;

  CashBackProductType({this.id, this.name});

  CashBackProductType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
