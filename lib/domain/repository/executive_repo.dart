import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/model/executive/executive_list_response_model.dart';
import '../../data/model/executive/executive_detail_response_model.dart';
import '../../data/model/executive/executive_commission_package_response_model.dart';
import '../../data/model/executive/executive_add_wallet_details_response_model.dart';

abstract class ExecutiveRepository {
  Future<Either<Failure, ExecutiveListResponseModel>> getExecutives({
    int page = 1,
    String? isActive,
    String? search,
  });
  Future<Either<Failure, ExecutiveDetailResponseModel>> getExecutiveDetail(String id);
  Future<Either<Failure, ExecutiveCommissionPackageResponseModel>> getExecutiveCommissionPackages();
  Future<Either<Failure, String>> updateExecutive(Map<String, dynamic> data);
  Future<Either<Failure, ExecutiveAddWalletDetailsResponseModel>> getExecutiveAddWalletDetails(String id);
  Future<Either<Failure, String>> addExecutiveWallet(String id, String amount);
  Future<Either<Failure, String>> createExecutive(Map<String, dynamic> data);
}
