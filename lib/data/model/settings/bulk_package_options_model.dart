class BulkPackageOptionsModel {
  bool? success;
  BulkPackageOptionsData? data;
  String? message;
  int? code;

  BulkPackageOptionsModel({this.success, this.data, this.message, this.code});

  BulkPackageOptionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? BulkPackageOptionsData.fromJson(json['data']) : null;
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

class BulkPackageOptionsData {
  List<PackageOption>? packages;
  List<UserTypeOption>? userTypes;
  List<StatusOption>? statuses;
  int? noOfRetailers;

  BulkPackageOptionsData({
    this.packages,
    this.userTypes,
    this.statuses,
    this.noOfRetailers,
  });

  BulkPackageOptionsData.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <PackageOption>[];
      json['packages'].forEach((v) {
        packages!.add(PackageOption.fromJson(v));
      });
    }
    if (json['user_types'] != null) {
      userTypes = <UserTypeOption>[];
      json['user_types'].forEach((v) {
        userTypes!.add(UserTypeOption.fromJson(v));
      });
    }
    if (json['statuses'] != null) {
      statuses = <StatusOption>[];
      json['statuses'].forEach((v) {
        statuses!.add(StatusOption.fromJson(v));
      });
    }
    noOfRetailers = json['no_of_retailers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    if (userTypes != null) {
      data['user_types'] = userTypes!.map((v) => v.toJson()).toList();
    }
    if (statuses != null) {
      data['statuses'] = statuses!.map((v) => v.toJson()).toList();
    }
    data['no_of_retailers'] = noOfRetailers;
    return data;
  }
}

class PackageOption {
  int? id;
  String? packageName;

  PackageOption({this.id, this.packageName});

  PackageOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['package_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    return data;
  }
}

class UserTypeOption {
  String? id;
  String? name;

  UserTypeOption({this.id, this.name});

  UserTypeOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class StatusOption {
  String? id;
  String? name;

  StatusOption({this.id, this.name});

  StatusOption.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString(); // Some IDs might be returned as strings or ints
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
