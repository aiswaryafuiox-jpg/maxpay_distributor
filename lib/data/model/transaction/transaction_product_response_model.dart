class TransactionProductResponseModel {
  final bool? success;
  final List<TransactionProduct>? data;
  final String? message;
  final int? code;

  TransactionProductResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory TransactionProductResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionProductResponseModel(
      success: json['success'],
      data: json['data'] != null
          ? List<TransactionProduct>.from(
              json['data'].map((x) => TransactionProduct.fromJson(x)))
          : null,
      message: json['message'],
      code: json['code'],
    );
  }
}

class TransactionProduct {
  final int? id;
  final String? name;
  final String? logo;

  TransactionProduct({
    this.id,
    this.name,
    this.logo,
  });

  factory TransactionProduct.fromJson(Map<String, dynamic> json) {
    return TransactionProduct(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
