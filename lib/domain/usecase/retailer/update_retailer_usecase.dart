import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/update_retailer_response_model.dart';
import '../../repository/retailer_repo.dart';

class UpdateRetailerUseCase {
  final RetailerRepository repository;

  UpdateRetailerUseCase(this.repository);

  Future<Either<Failure, UpdateRetailerResponseModel>> call(UpdateRetailerParams params) {
    return repository.updateRetailer(params);
  }
}

class UpdateRetailerParams {
  final String id;
  final String retailerName;
  final String regMobileNumber;
  final String whatsappNumber;
  final String email;
  final String address;
  final String gstNo;
  final String pincode;
  final String executiveId;
  final String registrationCharge;
  final String lowWalletAmount;
  final String autoTransferAmount;
  final String packageName;
  final String autoTransfer;
  final String status;
  final String transaction;

  UpdateRetailerParams({
    required this.id,
    required this.retailerName,
    required this.regMobileNumber,
    required this.whatsappNumber,
    required this.email,
    required this.address,
    required this.gstNo,
    required this.pincode,
    required this.executiveId,
    required this.registrationCharge,
    required this.lowWalletAmount,
    required this.autoTransferAmount,
    required this.packageName,
    required this.autoTransfer,
    required this.status,
    required this.transaction,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'retailer_name': retailerName,
      'reg_mobile_number': regMobileNumber,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'address': address,
      'gst_no': gstNo,
      'pincode': pincode,
      'executive_id': executiveId,
      'registration_charge': registrationCharge,
      'low_wallet_amount': lowWalletAmount,
      'auto_transfer_amount': autoTransferAmount,
      'package_name': packageName,
      'auto_transfer': autoTransfer,
      'status': status,
      'transaction': transaction,
    };
  }
}
