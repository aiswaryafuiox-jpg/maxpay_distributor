class Advertisement {
  bool? success;
  Data? data;
  String? message;
  int? code;

  Advertisement({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  Advertisement.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? Data.fromJson(json['data'])
        : null;
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
  List<Advertisements>? advertisements;

  Data({
    this.advertisements,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['advertisements'] != null) {
      advertisements = <Advertisements>[];

      json['advertisements'].forEach((v) {
        advertisements!.add(
          Advertisements.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (advertisements != null) {
      data['advertisements'] =
          advertisements!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Advertisements {
  int? id;
  String? mobile;
  String? name;
  String? companyName;
  String? adFor;
  int? districtId;
  int? pincodeId;
  String? webLink;
  String? youtubeLink;
  String? contactNo;
  String? fromDate;
  String? toDate;
  String? displayImage;
  String? adImage;
  int? status;

  // Backend sends "up" / "down"
  String? imageScreen;

  String? createdAt;
  String? updatedAt;

  Advertisements({
    this.id,
    this.mobile,
    this.name,
    this.companyName,
    this.adFor,
    this.districtId,
    this.pincodeId,
    this.webLink,
    this.youtubeLink,
    this.contactNo,
    this.fromDate,
    this.toDate,
    this.displayImage,
    this.adImage,
    this.status,
    this.imageScreen,
    this.createdAt,
    this.updatedAt,
  });

  Advertisements.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null
        ? int.tryParse(json['id'].toString())
        : null;

    mobile = json['mobile']?.toString();
    name = json['name']?.toString();
    companyName = json['company_name']?.toString();
    adFor = json['ad_for']?.toString();

    districtId = json['district_id'] != null
        ? int.tryParse(
            json['district_id'].toString(),
          )
        : null;

    pincodeId = json['pincode_id'] != null
        ? int.tryParse(
            json['pincode_id'].toString(),
          )
        : null;

    webLink = json['web_link']?.toString();
    youtubeLink = json['youtube_link']?.toString();
    contactNo = json['contact_no']?.toString();
    fromDate = json['from_date']?.toString();
    toDate = json['to_date']?.toString();

    displayImage =
        json['display_image']?.toString();

    adImage =
        json['ad_image']?.toString();

    status = json['status'] != null
        ? int.tryParse(
            json['status'].toString(),
          )
        : null;

    imageScreen =
        json['image_screen']?.toString();

    createdAt =
        json['created_at']?.toString();

    updatedAt =
        json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['company_name'] = companyName;
    data['ad_for'] = adFor;
    data['district_id'] = districtId;
    data['pincode_id'] = pincodeId;
    data['web_link'] = webLink;
    data['youtube_link'] = youtubeLink;
    data['contact_no'] = contactNo;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['display_image'] = displayImage;
    data['ad_image'] = adImage;
    data['status'] = status;
    data['image_screen'] = imageScreen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}




