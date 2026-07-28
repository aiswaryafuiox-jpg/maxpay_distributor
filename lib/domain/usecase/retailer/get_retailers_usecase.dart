import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/retailer_list_response_model.dart';
import '../../repository/retailer_repo.dart';

class GetRetailersUseCase {
  final RetailerRepository repository;

  GetRetailersUseCase(this.repository);

  Future<Either<Failure, RetailerListResponseModel>> call() {
    return repository.getRetailers();
  }
}
