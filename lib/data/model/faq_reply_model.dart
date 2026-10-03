class FaqReply {
  bool? success;
  Data? data;
  String? message;
  int? code;

  FaqReply({this.success, this.data, this.message, this.code});

  FaqReply.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? userId;
  String? faqId;
  String? comment;
  String? reply;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.userId,
    this.faqId,
    this.comment,
    this.reply,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    faqId = json['faq_id'];
    comment = json['comment'];
    reply = json['reply'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['faq_id'] = faqId;
    data['comment'] = comment;
    data['reply'] = reply;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
