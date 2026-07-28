// class WalletRetailersModel {
//   bool? success;
//   Data? data;
//   String? message;
//   int? code;

//   WalletRetailersModel({this.success, this.data, this.message, this.code});

//   WalletRetailersModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     message = json['message'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     data['code'] = this.code;
//     return data;
//   }
// }

// class Data {
//   int? total;
//   List<List>? list;

//   Data({this.total, this.list});

//   Data.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     if (json['list'] != null) {
//       list = <List>[];
//       json['list'].forEach((v) {
//         list!.add(new List.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total'] = this.total;
//     if (this.list != null) {
//       data['list'] = this.list!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class List {
//   int? id;
//   String? userId;
//   String? retailerName;
//   String? regMobileNumber;
//   int? walletAmount;
//   int? lowWallet;
//   int? transferAmount;
//   String? autoTransfer;

//   List(
//       {this.id,
//       this.userId,
//       this.retailerName,
//       this.regMobileNumber,
//       this.walletAmount,
//       this.lowWallet,
//       this.transferAmount,
//       this.autoTransfer});

//   List.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     retailerName = json['retailer_name'];
//     regMobileNumber = json['reg_mobile_number'];
//     walletAmount = json['wallet_amount'];
//     lowWallet = json['low_wallet'];
//     transferAmount = json['transfer_amount'];
//     autoTransfer = json['auto_transfer'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['retailer_name'] = this.retailerName;
//     data['reg_mobile_number'] = this.regMobileNumber;
//     data['wallet_amount'] = this.walletAmount;
//     data['low_wallet'] = this.lowWallet;
//     data['transfer_amount'] = this.transferAmount;
//     data['auto_transfer'] = this.autoTransfer;
//     return data;
//   }
// }