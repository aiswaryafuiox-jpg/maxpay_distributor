import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/cashback/cash_back_product_types_model.dart';
import 'package:maxpay/data/model/cashback/cash_back_model.dart';

abstract class CashBackRepository {
  Future<Either<Failure, CashBackProductTypesModel>> getCashBackProductTypes();
  Future<Either<Failure, CashBackModel>> getCashBackList(String productTypeId);
}
