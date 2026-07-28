class GetProfileResponseModel {
  bool? success;
  ProfileData? data;
  String? message;
  int? code;

  GetProfileResponseModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(
      success: json['success'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
      message: json['message'],
      code: json['code'],
    );
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

class ProfileData {
  int? id;
  String? userId;
  String? userType;
  String? name;
  String? address;
  String? billingAddress;
  String? pincode;
  String? email;
  String? phoneNumber;
  String? whatsappNumber;
  String? status;
  int? isActive;
  String? profileImg;

  ProfileData({
    this.id,
    this.userId,
    this.userType,
    this.name,
    this.address,
    this.billingAddress,
    this.pincode,
    this.email,
    this.phoneNumber,
    this.whatsappNumber,
    this.status,
    this.isActive,
    this.profileImg,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      userId: json['user_id'],
      userType: json['user_type'],
      name: json['name'],
      address: json['address'],
      billingAddress: json['billing_address'],
      pincode: json['pincode'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      whatsappNumber: json['whatsapp_number'],
      status: json['status'],
      isActive: json['is_active'],
      profileImg: json['profile_img'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['name'] = name;
    data['address'] = address;
    data['billing_address'] = billingAddress;
    data['pincode'] = pincode;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['status'] = status;
    data['is_active'] = isActive;
    data['profile_img'] = profileImg;
    return data;
  }
}
