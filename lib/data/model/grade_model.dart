class GradeModel {
  bool? success;
  GradeData? data;
  String? message;
  int? code;

  GradeModel({this.success, this.data, this.message, this.code});

  GradeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? GradeData.fromJson(json['data']) : null;
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

class GradeData {
  String? currentGrade;
  dynamic walletBalance;
  String? monthLabel;
  List<GradeDetail>? details;

  GradeData(
      {this.currentGrade,
      this.walletBalance,
      this.monthLabel,
      this.details});

  GradeData.fromJson(Map<String, dynamic> json) {
    currentGrade = json['current_grade'];
    walletBalance = json['wallet_balance'];
    monthLabel = json['month_label'];
    if (json['details'] != null) {
      details = <GradeDetail>[];
      json['details'].forEach((v) {
        details!.add(GradeDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_grade'] = currentGrade;
    data['wallet_balance'] = walletBalance;
    data['month_label'] = monthLabel;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GradeDetail {
  String? grade;
  num? dailyAverageBalance;
  num? monthlyCashback;

  GradeDetail({this.grade, this.dailyAverageBalance, this.monthlyCashback});

  GradeDetail.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    dailyAverageBalance = json['daily_average_balance'];
    monthlyCashback = json['monthly_cashback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['daily_average_balance'] = dailyAverageBalance;
    data['monthly_cashback'] = monthlyCashback;
    return data;
  }
}
