class ApproveWalletRequestModel {
  bool? success;
  ApproveWalletRequestData? data;
  String? message;
  int? code;

  ApproveWalletRequestModel({this.success, this.data, this.message, this.code});

  ApproveWalletRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ApproveWalletRequestData.fromJson(json['data']) : null;
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

class ApproveWalletRequestData {
  String? transactionId;
  dynamic amount;
  int? requestId;
  String? status;

  ApproveWalletRequestData(
      {this.transactionId, this.amount, this.requestId, this.status});

  ApproveWalletRequestData.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    amount = json['amount'];
    requestId = json['request_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['request_id'] = requestId;
    data['status'] = status;
    return data;
  }
}
