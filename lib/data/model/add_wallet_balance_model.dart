
class AddWalletBalanceModel {
    bool? success;
    Data? data;
    String? message;
    int? code;

    AddWalletBalanceModel({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    factory AddWalletBalanceModel.fromJson(Map<String, dynamic> json) => AddWalletBalanceModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
    String? userId;
    int? totalBalance;

    Data({
        this.userId,
        this.totalBalance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        totalBalance: json["total_balance"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "total_balance": totalBalance,
    };
}
