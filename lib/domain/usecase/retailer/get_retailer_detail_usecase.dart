import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/retailer_detail_response_model.dart';
import '../../repository/retailer_repo.dart';

class GetRetailerDetailUseCase {
  final RetailerRepository repository;

  GetRetailerDetailUseCase(this.repository);

  Future<Either<Failure, RetailerDetailResponseModel>> call(int id) {
    return repository.getRetailerDetail(id);
  }
}
