import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/data/model/wallet_request_model.dart';
import 'package:maxpay/domain/repository/wallet_request_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_service.dart';

class WalletRequestRepoImpl implements WalletRequestRepository {
  final ApiService apiService;

  WalletRequestRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WalletRequest>> walletRequest({
    required String amount,
    required String paymenttype,
    required String utrno,
    required String bankid,
    required String description,
    required String receipt,
  }) async {
    try {
      final formData = FormData.fromMap({
        "payment_for": "wallet",
        "request_amount": amount,
        "payment_type": paymenttype,
        "bank_id": bankid,
        "ref_number": utrno,
        "outstanding_amount": "", // Or a specific value if required
        "description": description,
        "receipt": await MultipartFile.fromFile(
          receipt,
          filename: "receipt.jpg",
        ),
      });

      final response = await apiService.post(
        ApiRoutes.requestWallet,
        data: formData,
      );

      final model = WalletRequest.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
