import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../data/model/retailer/retailer_detail_response_model.dart';
import '../../data/model/retailer/retailer_list_response_model.dart';
import '../../data/model/retailer/commission_package_response_model.dart';
import '../../data/model/retailer/create_retailer_response_model.dart';
import '../../data/model/retailer/update_retailer_response_model.dart';
import '../../data/model/retailer/add_wallet_details_response_model.dart';
import '../../data/model/retailer/add_wallet_response_model.dart';
import '../usecase/retailer/create_retailer_usecase.dart';
import '../usecase/retailer/update_retailer_usecase.dart';
import '../usecase/retailer/add_wallet_usecase.dart';

abstract class RetailerRepository {
  Future<Either<Failure, RetailerListResponseModel>> getRetailers({
    int page = 1,
    String? isActive,
    String? search,
  });
  Future<Either<Failure, RetailerDetailResponseModel>> getRetailerDetail(
    int id,
  );
  Future<Either<Failure, CommissionPackageResponseModel>>
  getCommissionPackages();
  Future<Either<Failure, CreateRetailerResponseModel>> createRetailer(
    CreateRetailerParams params,
  );
  Future<Either<Failure, UpdateRetailerResponseModel>> updateRetailer(
    UpdateRetailerParams params,
  );
  Future<Either<Failure, AddWalletDetailsResponseModel>> getAddWalletDetails(
    int id,
  );
  Future<Either<Failure, AddWalletResponseModel>> addWallet(
    AddWalletParams params,
  );
}
