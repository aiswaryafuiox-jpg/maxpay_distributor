// To parse this JSON data, do
//
//     final retailerListResponseModel = retailerListResponseModelFromJson(jsonString);

import 'dart:convert';

RetailerListResponseModel retailerListResponseModelFromJson(String str) =>
    RetailerListResponseModel.fromJson(json.decode(str));

String retailerListResponseModelToJson(RetailerListResponseModel data) =>
    json.encode(data.toJson());

class RetailerListResponseModel {
  bool? success;
  RetailerListData? data;
  String? message;
  int? code;

  RetailerListResponseModel({this.success, this.data, this.message, this.code});

  factory RetailerListResponseModel.fromJson(Map<String, dynamic> json) =>
      RetailerListResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : RetailerListData.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class RetailerListData {
  int? totalCount;
  int? activeCount;
  int? inactiveCount;
  Pagination? pagination;
  List<Retailer>? retailers;

  RetailerListData({
    this.totalCount,
    this.activeCount,
    this.inactiveCount,
    this.pagination,
    this.retailers,
  });

  factory RetailerListData.fromJson(Map<String, dynamic> json) =>
      RetailerListData(
        totalCount: json["total_count"],
        activeCount: json["active_count"],
        inactiveCount: json["inactive_count"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        retailers: json["retailers"] == null
            ? []
            : List<Retailer>.from(
                json["retailers"]!.map((x) => Retailer.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "active_count": activeCount,
    "inactive_count": inactiveCount,
    "pagination": pagination?.toJson(),
    "retailers": retailers == null
        ? []
        : List<dynamic>.from(retailers!.map((x) => x.toJson())),
  };
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? filteredCount;
  int? from;
  int? to;
  bool? hasMorePages;

  Pagination({
    this.currentPage,
    this.perPage,
    this.filteredCount,
    this.from,
    this.to,
    this.hasMorePages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    filteredCount: json["filtered_count"],
    from: json["from"],
    to: json["to"],
    hasMorePages: json["has_more_pages"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "filtered_count": filteredCount,
    "from": from,
    "to": to,
    "has_more_pages": hasMorePages,
  };
}

class Retailer {
  int? id;
  String? userId;
  String? retailerName;
  String? regMobileNumber;
  dynamic executiveId;
  dynamic executiveName;
  String? commissionPackage;
  int? isActive;
  String? walletAmount;
  String? dueAmount;
  String? todayOnline;
  String? todayTransfer;

  Retailer({
    this.id,
    this.userId,
    this.retailerName,
    this.regMobileNumber,
    this.executiveId,
    this.executiveName,
    this.commissionPackage,
    this.isActive,
    this.walletAmount,
    this.dueAmount,
    this.todayOnline,
    this.todayTransfer,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
    id: json["id"],
    userId: json["user_id"],
    retailerName: json["retailer_name"],
    regMobileNumber: json["reg_mobile_number"],
    executiveId: json["executive_id"],
    executiveName: json["executive_name"],
    commissionPackage: json["commission_package"],
    isActive: json["is_active"],
    walletAmount: json["wallet_amount"],
    dueAmount: json["due_amount"],
    todayOnline: json["today_online"],
    todayTransfer: json["today_transfer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "retailer_name": retailerName,
    "reg_mobile_number": regMobileNumber,
    "executive_id": executiveId,
    "executive_name": executiveName,
    "commission_package": commissionPackage,
    "is_active": isActive,
    "wallet_amount": walletAmount,
    "due_amount": dueAmount,
    "today_online": todayOnline,
    "today_transfer": todayTransfer,
  };
}
