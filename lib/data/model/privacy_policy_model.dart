class PrivacyPolicyModel {
  bool? success;
  PrivacyPolicyData? data;
  String? message;
  int? code;

  PrivacyPolicyModel({this.success, this.data, this.message, this.code});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : PrivacyPolicyData.fromJson(json["data"]),
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

class PrivacyPolicyData {
  String? privacyPolicy;

  PrivacyPolicyData({this.privacyPolicy});

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyData(
        privacyPolicy: json["privacy_policy"],
      );

  Map<String, dynamic> toJson() => {
        "privacy_policy": privacyPolicy,
      };
}
