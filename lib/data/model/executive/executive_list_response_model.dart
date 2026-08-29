// To parse this JSON data, do
//
//     final executiveListResponseModel = executiveListResponseModelFromJson(jsonString);

import 'dart:convert';

ExecutiveListResponseModel executiveListResponseModelFromJson(String str) =>
    ExecutiveListResponseModel.fromJson(json.decode(str));

String executiveListResponseModelToJson(ExecutiveListResponseModel data) =>
    json.encode(data.toJson());

class ExecutiveListResponseModel {
  bool? success;
  ExecutiveListData? data;
  String? message;
  int? code;

  ExecutiveListResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory ExecutiveListResponseModel.fromJson(Map<String, dynamic> json) =>
      ExecutiveListResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ExecutiveListData.fromJson(json["data"]),
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

class ExecutiveListData {
  int? totalCount;
  int? activeCount;
  int? inactiveCount;
  Pagination? pagination;
  List<Executive>? executives;

  ExecutiveListData({
    this.totalCount,
    this.activeCount,
    this.inactiveCount,
    this.pagination,
    this.executives,
  });

  factory ExecutiveListData.fromJson(Map<String, dynamic> json) =>
      ExecutiveListData(
        totalCount: json["total_count"],
        activeCount: json["active_count"],
        inactiveCount: json["inactive_count"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        executives: json["executives"] == null
            ? []
            : List<Executive>.from(
                json["executives"]!.map((x) => Executive.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "active_count": activeCount,
    "inactive_count": inactiveCount,
    "pagination": pagination?.toJson(),
    "executives": executives == null
        ? []
        : List<dynamic>.from(executives!.map((x) => x.toJson())),
  };
}

class Executive {
  int? id;
  String? userId;
  String? executiveName;
  String? regMobileNumber;
  int? isActive;
  String? walletAmount;
  String? dueAmount;
  String? todayOnline;
  String? todayTransfer;

  Executive({
    this.id,
    this.userId,
    this.executiveName,
    this.regMobileNumber,
    this.isActive,
    this.walletAmount,
    this.dueAmount,
    this.todayOnline,
    this.todayTransfer,
  });

  factory Executive.fromJson(Map<String, dynamic> json) => Executive(
    id: json["id"],
    userId: json["user_id"],
    executiveName: json["executive_name"],
    regMobileNumber: json["reg_mobile_number"],
    isActive: json["is_active"],
    walletAmount: json["wallet_amount"],
    dueAmount: json["due_amount"],
    todayOnline: json["today_online"],
    todayTransfer: json["today_transfer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "executive_name": executiveName,
    "reg_mobile_number": regMobileNumber,
    "is_active": isActive,
    "wallet_amount": walletAmount,
    "due_amount": dueAmount,
    "today_online": todayOnline,
    "today_transfer": todayTransfer,
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
