class TransferDetailModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  TransferDetailModel({this.success, this.data, this.message, this.code});

  TransferDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? value;

  Data({this.id, this.name, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}