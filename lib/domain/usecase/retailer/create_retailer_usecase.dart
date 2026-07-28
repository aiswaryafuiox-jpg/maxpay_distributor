import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/create_retailer_response_model.dart';
import '../../repository/retailer_repo.dart';

class CreateRetailerUseCase {
  final RetailerRepository repository;

  CreateRetailerUseCase(this.repository);

  Future<Either<Failure, CreateRetailerResponseModel>> call(CreateRetailerParams params) {
    return repository.createRetailer(params);
  }
}

class CreateRetailerParams {
  final String retailerName;
  final String regMobileNumber;
  final String commissionPackage;
  final String billingAddress;
  final String pincode;
  final String registrationCharge;

  CreateRetailerParams({
    required this.retailerName,
    required this.regMobileNumber,
    required this.commissionPackage,
    required this.billingAddress,
    required this.pincode,
    required this.registrationCharge,
  });

  Map<String, dynamic> toJson() {
    return {
      'retailer_name': retailerName,
      'reg_mobile_number': regMobileNumber,
      'commission_package': commissionPackage,
      'billing_address': billingAddress,
      'pincode': pincode,
      'registration_charge': registrationCharge,
    };
  }
}
