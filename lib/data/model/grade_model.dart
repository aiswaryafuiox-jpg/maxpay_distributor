// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
    bool? success;
    GradeData? data;
    String? message;
    int? code;

    GradeModel({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        success: json["success"],
        data: json["data"] == null ? null : GradeData.fromJson(json["data"]),
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

class GradeData {
    Distributor? distributor;
    int? walletBalance;
    TMonth? currentMonth;
    TMonth? lastMonth;
    DisplayCard? displayCard;
    List<GradeSlab>? gradeSlabs;

    GradeData({
        this.distributor,
        this.walletBalance,
        this.currentMonth,
        this.lastMonth,
        this.displayCard,
        this.gradeSlabs,
    });

    factory GradeData.fromJson(Map<String, dynamic> json) => GradeData(
        distributor: json["distributor"] == null ? null : Distributor.fromJson(json["distributor"]),
        walletBalance: json["wallet_balance"],
        currentMonth: json["current_month"] == null ? null : TMonth.fromJson(json["current_month"]),
        lastMonth: json["last_month"] == null ? null : TMonth.fromJson(json["last_month"]),
        displayCard: json["display_card"] == null ? null : DisplayCard.fromJson(json["display_card"]),
        gradeSlabs: json["grade_slabs"] == null ? [] : List<GradeSlab>.from(json["grade_slabs"]!.map((x) => GradeSlab.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "distributor": distributor?.toJson(),
        "wallet_balance": walletBalance,
        "current_month": currentMonth?.toJson(),
        "last_month": lastMonth?.toJson(),
        "display_card": displayCard?.toJson(),
        "grade_slabs": gradeSlabs == null ? [] : List<dynamic>.from(gradeSlabs!.map((x) => x.toJson())),
    };
}

class TMonth {
    String? grade;
    String? monthKey;
    String? monthLabel;
    int? daysTracked;
    int? actualAvg;
    String? label;
    dynamic cashback;

    TMonth({
        this.grade,
        this.monthKey,
        this.monthLabel,
        this.daysTracked,
        this.actualAvg,
        this.label,
        this.cashback,
    });

    factory TMonth.fromJson(Map<String, dynamic> json) => TMonth(
        grade: json["grade"],
        monthKey: json["month_key"],
        monthLabel: json["month_label"],
        daysTracked: json["days_tracked"],
        actualAvg: json["actual_avg"],
        label: json["label"],
        cashback: json["cashback"],
    );

    Map<String, dynamic> toJson() => {
        "grade": grade,
        "month_key": monthKey,
        "month_label": monthLabel,
        "days_tracked": daysTracked,
        "actual_avg": actualAvg,
        "label": label,
        "cashback": cashback,
    };
}

class DisplayCard {
    String? grade;
    String? label;
    String? monthLabel;
    String? source;

    DisplayCard({
        this.grade,
        this.label,
        this.monthLabel,
        this.source,
    });

    factory DisplayCard.fromJson(Map<String, dynamic> json) => DisplayCard(
        grade: json["grade"],
        label: json["label"],
        monthLabel: json["month_label"],
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "grade": grade,
        "label": label,
        "month_label": monthLabel,
        "source": source,
    };
}

class Distributor {
    String? userId;
    String? distributorName;
    String? mobile;

    Distributor({
        this.userId,
        this.distributorName,
        this.mobile,
    });

    factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        userId: json["user_id"],
        distributorName: json["distributor_name"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "distributor_name": distributorName,
        "mobile": mobile,
    };
}

class GradeSlab {
    int? sno;
    String? grade;
    int? dailyAverageBalance;
    int? monthlyCashBack;

    GradeSlab({
        this.sno,
        this.grade,
        this.dailyAverageBalance,
        this.monthlyCashBack,
    });

    factory GradeSlab.fromJson(Map<String, dynamic> json) => GradeSlab(
        sno: json["sno"],
        grade: json["grade"],
        dailyAverageBalance: json["daily_average_balance"],
        monthlyCashBack: json["monthly_cash_back"],
    );

    Map<String, dynamic> toJson() => {
        "sno": sno,
        "grade": grade,
        "daily_average_balance": dailyAverageBalance,
        "monthly_cash_back": monthlyCashBack,
    };
}
