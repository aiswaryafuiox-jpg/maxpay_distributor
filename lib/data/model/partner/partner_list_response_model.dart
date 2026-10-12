class MappedDistResponseModel {
  bool? success;
  MappedDistData? data;
  String? message;
  int? code;

  MappedDistResponseModel({this.success, this.data, this.message, this.code});

  MappedDistResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MappedDistData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}

class MappedDistData {
  int? distributorId;
  String? distributorUserId;
  List<StockistItem>? stockistList;

  MappedDistData({
    this.distributorId,
    this.distributorUserId,
    this.stockistList,
  });

  MappedDistData.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributor_id'];
    distributorUserId = json['distributor_user_id']?.toString();
    if (json['stockist_list'] != null) {
      stockistList = <StockistItem>[];
      json['stockist_list'].forEach((v) {
        stockistList!.add(StockistItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['distributor_id'] = distributorId;
    map['distributor_user_id'] = distributorUserId;
    if (stockistList != null) {
      map['stockist_list'] = stockistList!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StockistItem {
  int? id;
  String? userId;
  String? companyName;
  String? stockistId;
  String? phone;
  String? mobile;
  String? mobileNumber;
  String? phoneNumber;
  String? regMobileNumber;
  String? walletAmount;

  StockistItem({
    this.id,
    this.userId,
    this.companyName,
    this.stockistId,
    this.phone,
    this.mobile,
    this.mobileNumber,
    this.phoneNumber,
    this.regMobileNumber,
    this.walletAmount,
  });

  StockistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id']?.toString();
    companyName = (json['company_name'] ?? json['name'])?.toString();
    stockistId = json['stockist_id']?.toString();
    phone = json['phone']?.toString();
    mobile = json['mobile']?.toString();
    mobileNumber = json['mobile_number']?.toString();
    phoneNumber = json['phone_number']?.toString();
    regMobileNumber = json['reg_mobile_number']?.toString();
    walletAmount =
        (json['wallet_amount'] ??
                json['walletAmount'] ??
                json['wallet'] ??
                json['balance'] ??
                json['wallet_balance'])
            ?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['company_name'] = companyName;
    map['stockist_id'] = stockistId;
    if (phone != null) map['phone'] = phone;
    if (mobile != null) map['mobile'] = mobile;
    if (mobileNumber != null) map['mobile_number'] = mobileNumber;
    if (phoneNumber != null) map['phone_number'] = phoneNumber;
    if (regMobileNumber != null) map['reg_mobile_number'] = regMobileNumber;
    if (walletAmount != null) map['wallet_amount'] = walletAmount;
    return map;
  }

  /// Display helper for partner name
  String get displayName {
    if (companyName != null && companyName!.trim().isNotEmpty) {
      return companyName!.trim();
    }
    if (userId != null && userId!.trim().isNotEmpty) {
      return userId!.trim();
    }
    return "-";
  }

  /// Display helper for phone number
  String get displayPhone {
    final num =
        mobile ?? phone ?? mobileNumber ?? phoneNumber ?? regMobileNumber;
    if (num != null && num.trim().isNotEmpty) {
      final clean = num.trim();
      return clean.startsWith("+91") ? clean : "+91 $clean";
    }
    // If no phone number is provided by backend, fallback to user_id or '-'
    if (userId != null && userId!.trim().isNotEmpty) {
      return userId!.trim();
    }
    return "-";
  }

  /// Display helper for wallet amount
  String get displayWalletAmount {
    if (walletAmount != null && walletAmount!.trim().isNotEmpty) {
      final clean = walletAmount!.trim();
      final numVal = double.tryParse(clean.replaceAll(",", ""));
      if (numVal != null) {
        return "₹${numVal.toStringAsFixed(2)}";
      }
      return clean.startsWith("₹") ? clean : "₹$clean";
    }
    return "₹500.00";
  }
}
