class HomeCardModel {
  bool? success;
  HomeCardData? data;
  String? message;
  int? code;

  HomeCardModel({this.success, this.data, this.message, this.code});

  HomeCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? HomeCardData.fromJson(json['data']) : null;
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

class HomeCardData {
  TransactionSummary? success;
  TransactionSummary? failed;
  TransactionSummary? processing;

  HomeCardData({this.success, this.failed, this.processing});

  HomeCardData.fromJson(Map<String, dynamic> json) {
    success = json['success'] != null
        ? TransactionSummary.fromJson(json['success'])
        : null;
    failed = json['failed'] != null
        ? TransactionSummary.fromJson(json['failed'])
        : null;
    processing = json['processing'] != null
        ? TransactionSummary.fromJson(json['processing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (success != null) {
      data['success'] = success!.toJson();
    }
    if (failed != null) {
      data['failed'] = failed!.toJson();
    }
    if (processing != null) {
      data['processing'] = processing!.toJson();
    }
    return data;
  }
}

class TransactionSummary {
  dynamic amount;
  dynamic count;

  TransactionSummary({this.amount, this.count});

  TransactionSummary.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['count'] = count;
    return data;
  }
}
