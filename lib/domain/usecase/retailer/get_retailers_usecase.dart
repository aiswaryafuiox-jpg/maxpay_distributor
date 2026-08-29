import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../data/model/retailer/retailer_list_response_model.dart';
import '../../repository/retailer_repo.dart';

class GetRetailersParams {
  final int page;
  final String? isActive;
  final String? search;

  GetRetailersParams({this.page = 1, this.isActive, this.search});
}

class GetRetailersUseCase {
  final RetailerRepository repository;

  GetRetailersUseCase(this.repository);

  Future<Either<Failure, RetailerListResponseModel>> call([GetRetailersParams? params]) {
    final p = params ?? GetRetailersParams();
    return repository.getRetailers(page: p.page, isActive: p.isActive, search: p.search);
  }
}
