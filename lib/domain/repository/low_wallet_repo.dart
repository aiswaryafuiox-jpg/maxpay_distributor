import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../data/model/low_wallet_retailers_model.dart';

abstract class LowWalletRepository {
  Future<Either<Failure, LowWalletRetailersModel>> getLowWalletRetailers();
}
