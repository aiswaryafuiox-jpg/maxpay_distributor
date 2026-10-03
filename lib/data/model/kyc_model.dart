class KycModel {
  bool? success;
  KycData? data;
  String? message;
  int? code;

  KycModel({this.success, this.data, this.message, this.code});

  KycModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? KycData.fromJson(json['data']) : null;
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

class KycData {
  int? kycId;
  String? email;
  String? whatsappNumber;
  String? cancelledCheck;
  String? gstNo;
  String? pan;
  String? status;
  String? cancelledCheckStatus;
  String? gstStatus;
  String? panStatus;
  String? rejectReason;
  String? gstRejectReason;
  int? kycSubmitted;

  KycData({
    this.kycId,
    this.email,
    this.whatsappNumber,
    this.cancelledCheck,
    this.gstNo,
    this.pan,
    this.status,
    this.cancelledCheckStatus,
    this.gstStatus,
    this.panStatus,
    this.rejectReason,
    this.gstRejectReason,
    this.kycSubmitted,
  });

  KycData.fromJson(Map<String, dynamic> json) {
    kycId = json['kyc_id'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    cancelledCheck = json['cancelled_check'];
    gstNo = json['gst_no'];
    pan = json['pan'];
    status = json['status'];
    cancelledCheckStatus = json['cancelled_check_status'];
    gstStatus = json['gst_status'];
    panStatus = json['pan_status'];
    rejectReason = json['reject_reason'];
    gstRejectReason = json['gst_reject_reason'];
    kycSubmitted = json['kyc_submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kyc_id'] = kycId;
    data['email'] = email;
    data['whatsapp_number'] = whatsappNumber;
    data['cancelled_check'] = cancelledCheck;
    data['gst_no'] = gstNo;
    data['pan'] = pan;
    data['status'] = status;
    data['cancelled_check_status'] = cancelledCheckStatus;
    data['gst_status'] = gstStatus;
    data['pan_status'] = panStatus;
    data['reject_reason'] = rejectReason;
    data['gst_reject_reason'] = gstRejectReason;
    data['kyc_submitted'] = kycSubmitted;
    return data;
  }
}
