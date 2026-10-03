// To parse this JSON data, do
//
//     final getProfileResponseModel = getProfileResponseModelFromJson(jsonString);

import 'dart:convert';

GetProfileResponseModel getProfileResponseModelFromJson(String str) => GetProfileResponseModel.fromJson(json.decode(str));

String getProfileResponseModelToJson(GetProfileResponseModel data) => json.encode(data.toJson());

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

    factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) => GetProfileResponseModel(
        success: json["success"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
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

    static String? _parseString(dynamic value) {
      if (value == null) return null;
      final str = value.toString().trim();
      if (str.toLowerCase() == 'null' || str.isEmpty) return null;
      return str;
    }

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        userId: _parseString(json["user_id"]),
        userType: _parseString(json["user_type"]),
        name: _parseString(json["name"]),
        address: _parseString(json["address"]),
        billingAddress: _parseString(json["billing_address"]),
        pincode: _parseString(json["pincode"]),
        email: _parseString(json["email"]),
        phoneNumber: _parseString(json["phone_number"]),
        whatsappNumber: _parseString(json["whatsapp_number"]),
        status: _parseString(json["status"]),
        isActive: json["is_active"],
        profileImg: _parseString(json["profile_img"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_type": userType,
        "name": name,
        "address": address,
        "billing_address": billingAddress,
        "pincode": pincode,
        "email": email,
        "phone_number": phoneNumber,
        "whatsapp_number": whatsappNumber,
        "status": status,
        "is_active": isActive,
        "profile_img": profileImg,
    };
}
