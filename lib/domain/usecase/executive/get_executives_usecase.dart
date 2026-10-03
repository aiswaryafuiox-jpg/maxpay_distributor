import 'package:dartz/dartz.dart';
import 'package:maxpay/data/model/executive/executive_list_response_model.dart';
import 'package:maxpay/domain/repository/executive_repo.dart';
import '../../../core/error/failure.dart';

class GetExecutivesParams {
  final int page;
  final String? isActive;
  final String? search;

  GetExecutivesParams({this.page = 1, this.isActive, this.search});
}

class GetExecutivesUseCase {
  final ExecutiveRepository repository;

  GetExecutivesUseCase(this.repository);

  Future<Either<Failure, ExecutiveListResponseModel>> call([GetExecutivesParams? params]) {
    final p = params ?? GetExecutivesParams();
    return repository.getExecutives(page: p.page, isActive: p.isActive, search: p.search);
  }
}
