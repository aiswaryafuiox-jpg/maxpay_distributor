// To parse this JSON data, do
//
//     final createQrResponseModel = createQrResponseModelFromJson(jsonString);

import 'dart:convert';

CreateQrResponseModel createQrResponseModelFromJson(String str) => CreateQrResponseModel.fromJson(json.decode(str));

String createQrResponseModelToJson(CreateQrResponseModel data) => json.encode(data.toJson());

class CreateQrResponseModel {
    bool? success;
    CreateQrResponseModelData? data;
    String? message;
    int? code;

    CreateQrResponseModel({
        this.success,
        this.data,
        this.message,
        this.code,
    });

    factory CreateQrResponseModel.fromJson(Map<String, dynamic> json) => CreateQrResponseModel(
        success: json["success"],
        data: json["data"] == null ? null : CreateQrResponseModelData.fromJson(json["data"]),
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

class CreateQrResponseModelData {
    bool? status;
    String? amount;
    Ekqr? ekqr;
    Worldline? worldline;

    CreateQrResponseModelData({
        this.status,
        this.amount,
        this.ekqr,
        this.worldline,
    });

    factory CreateQrResponseModelData.fromJson(Map<String, dynamic> json) => CreateQrResponseModelData(
        status: json["status"],
        amount: json["amount"],
        ekqr: json["ekqr"] == null ? null : Ekqr.fromJson(json["ekqr"]),
        worldline: json["worldline"] == null ? null : Worldline.fromJson(json["worldline"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "amount": amount,
        "ekqr": ekqr?.toJson(),
        "worldline": worldline?.toJson(),
    };
}

class Ekqr {
    bool? status;
    String? txnId;
    int? amount;
    String? upiLink;
    dynamic qrImage;
    PaymentApps? paymentApps;
    String? expiresAt;
    int? expirySeconds;

    Ekqr({
        this.status,
        this.txnId,
        this.amount,
        this.upiLink,
        this.qrImage,
        this.paymentApps,
        this.expiresAt,
        this.expirySeconds,
    });

    factory Ekqr.fromJson(Map<String, dynamic> json) => Ekqr(
        status: json["status"],
        txnId: json["txn_id"],
        amount: json["amount"],
        upiLink: json["upi_link"],
        qrImage: json["qr_image"],
        paymentApps: json["payment_apps"] == null ? null : PaymentApps.fromJson(json["payment_apps"]),
        expiresAt: json["expires_at"],
        expirySeconds: json["expiry_seconds"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "txn_id": txnId,
        "amount": amount,
        "upi_link": upiLink,
        "qr_image": qrImage,
        "payment_apps": paymentApps?.toJson(),
        "expires_at": expiresAt,
        "expiry_seconds": expirySeconds,
    };
}

class PaymentApps {
    String? gpay;
    String? phonepe;
    String? paytm;

    PaymentApps({
        this.gpay,
        this.phonepe,
        this.paytm,
    });

    factory PaymentApps.fromJson(Map<String, dynamic> json) => PaymentApps(
        gpay: json["gpay"],
        phonepe: json["phonepe"],
        paytm: json["paytm"],
    );

    Map<String, dynamic> toJson() => {
        "gpay": gpay,
        "phonepe": phonepe,
        "paytm": paytm,
    };
}

class Worldline {
    bool? status;
    String? txnId;
    String? amount;
    WorldlineData? data;

    Worldline({
        this.status,
        this.txnId,
        this.amount,
        this.data,
    });

    factory Worldline.fromJson(Map<String, dynamic> json) => Worldline(
        status: json["status"],
        txnId: json["txn_id"],
        amount: json["amount"],
        data: json["data"] == null ? null : WorldlineData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "txn_id": txnId,
        "amount": amount,
        "data": data?.toJson(),
    };
}

class WorldlineData {
    String? merchantId;
    String? token;
    String? deviceId;
    String? consumerId;
    String? consumerMobileNo;
    String? consumerEmailId;
    String? txnId;
    String? currency;
    String? paymentMode;
    List<Item>? items;

    WorldlineData({
        this.merchantId,
        this.token,
        this.deviceId,
        this.consumerId,
        this.consumerMobileNo,
        this.consumerEmailId,
        this.txnId,
        this.currency,
        this.paymentMode,
        this.items,
    });

    factory WorldlineData.fromJson(Map<String, dynamic> json) => WorldlineData(
        merchantId: json["merchantId"],
        token: json["token"],
        deviceId: json["deviceId"],
        consumerId: json["consumerId"],
        consumerMobileNo: json["consumerMobileNo"],
        consumerEmailId: json["consumerEmailId"],
        txnId: json["txnId"],
        currency: json["currency"],
        paymentMode: json["paymentMode"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "merchantId": merchantId,
        "token": token,
        "deviceId": deviceId,
        "consumerId": consumerId,
        "consumerMobileNo": consumerMobileNo,
        "consumerEmailId": consumerEmailId,
        "txnId": txnId,
        "currency": currency,
        "paymentMode": paymentMode,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? itemId;
    String? amount;
    String? comAmt;

    Item({
        this.itemId,
        this.amount,
        this.comAmt,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        amount: json["amount"],
        comAmt: json["comAmt"],
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "amount": amount,
        "comAmt": comAmt,
    };
}
