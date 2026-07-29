import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/statement/statement_descriptions_model.dart';
import 'package:maxpay/data/model/statement/statement_detail_model.dart';
import 'package:maxpay/data/model/statement/statement_list_model.dart';

class StatementListParams {
  final String fromDate;
  final String toDate;
  final String description;
  final String search;

  StatementListParams({
    required this.fromDate,
    required this.toDate,
    required this.description,
    required this.search,
  });

  Map<String, dynamic> toJson() {
    return {
      'from_date': fromDate,
      'to_date': toDate,
      'description': description,
      'search': search,
    };
  }
}

abstract class StatementRepository {
  Future<Either<Failure, StatementDescriptionsModel>> getStatementDescriptions();
  Future<Either<Failure, StatementListModel>> getStatementList(StatementListParams params);
  Future<Either<Failure, StatementDetailModel>> getStatementDetail(String id);
}
