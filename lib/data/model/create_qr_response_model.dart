class CreateQrResponseModel {
  bool? success;
  CreateQrData? data;
  String? message;
  int? code;

  String? get txnId => data?.txnId;
  String? get upiLink => data?.upiLink;
  String? get phonepeLink => data?.phonepeLink;
  String? get gpayLink => data?.gpayLink;

  CreateQrResponseModel({this.success, this.data, this.message, this.code});

  CreateQrResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CreateQrData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
      'code': code,
    };
  }
}

class CreateQrData {
  bool? status;
  String? txnId;
  String? amount;
  String? upiLink;
  String? gpayLink;
  String? phonepeLink;
  dynamic qrImage;

  CreateQrData({
    this.status,
    this.txnId,
    this.amount,
    this.upiLink,
    this.gpayLink,
    this.phonepeLink,
    this.qrImage,
  });

  CreateQrData copyWith({
    bool? status,
    String? txnId,
    String? amount,
    String? upiLink,
    String? gpayLink,
    String? phonepeLink,
    dynamic qrImage,
  }) => CreateQrData(
    status: status ?? this.status,
    txnId: txnId ?? this.txnId,
    amount: amount ?? this.amount,
    upiLink: upiLink ?? this.upiLink,
    gpayLink: gpayLink ?? this.gpayLink,
    phonepeLink: phonepeLink ?? this.phonepeLink,
    qrImage: qrImage ?? this.qrImage,
  );

  factory CreateQrData.fromJson(Map<String, dynamic> json) => CreateQrData(
    status: json["status"],
    txnId: json["txn_id"],
    amount: json["amount"],
    upiLink: json["upi_link"],
    gpayLink: json["gpay_link"],
    phonepeLink: json["phonepe_link"],
    qrImage: json["qr_image"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "txn_id": txnId,
    "amount": amount,
    "upi_link": upiLink,
    "gpay_link": gpayLink,
    "phonepe_link": phonepeLink,
    "qr_image": qrImage,
  };
}
