// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

Faq faqFromJson(String str) => Faq.fromJson(json.decode(str));

String faqToJson(Faq data) => json.encode(data.toJson());

class Faq {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  Faq({this.success, this.data, this.message, this.code});

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class Data {
  int? id;
  String? title;
  String? businessType;
  String? userType;
  DateTime? liveFromDate;
  DateTime? liveToDate;
  int? commentBox;
  String? replyOne;
  String? replyTwo;
  int? districtId;
  String? image;
  String? isreply;
  String? createdAt;

  Data({
    this.id,
    this.title,
    this.businessType,
    this.userType,
    this.liveFromDate,
    this.liveToDate,
    this.commentBox,
    this.replyOne,
    this.replyTwo,
    this.districtId,
    this.image,
    this.isreply,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    businessType: json["business_type"],
    userType: json["user_type"],
    liveFromDate: json["live_from_date"] == null
        ? null
        : DateTime.parse(json["live_from_date"]),
    liveToDate: json["live_to_date"] == null
        ? null
        : DateTime.parse(json["live_to_date"]),
    commentBox: json["comment_box"],
    replyOne: json["reply_one"],
    replyTwo: json["reply_two"],
    districtId: json["district_id"],
    image: json["image"],
    isreply: _normalizeIsReply(json["is_reply"]), // 👈 fix
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "business_type": businessType,
    "user_type": userType,
    "live_from_date": liveFromDate == null
        ? null
        : "${liveFromDate!.year.toString().padLeft(4, '0')}-${liveFromDate!.month.toString().padLeft(2, '0')}-${liveFromDate!.day.toString().padLeft(2, '0')}",
    "live_to_date": liveToDate == null
        ? null
        : "${liveToDate!.year.toString().padLeft(4, '0')}-${liveToDate!.month.toString().padLeft(2, '0')}-${liveToDate!.day.toString().padLeft(2, '0')}",
    "comment_box": commentBox,
    "reply_one": replyOne,
    "reply_two": replyTwo,
    "district_id": districtId,
    "image": image,
    "is_reply": isreply,
    "created_at": createdAt,
  };

  /// The backend sends `is_reply` as a raw int (0 or 1),
  /// but we store it as a String? ("0" / "1") for easy comparison
  /// elsewhere in the app (e.g. `faqData.isreply == "1"`).
  static String? _normalizeIsReply(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value ? "1" : "0";
    return value.toString();
  }
}