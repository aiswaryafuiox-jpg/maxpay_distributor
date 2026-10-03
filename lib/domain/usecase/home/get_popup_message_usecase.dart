import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/popup_message_mode.dart';
import 'package:maxpay/domain/repository/popup_message_repo.dart';

class GetPopupMessageUseCase {
  final PopupMessageRepository repository;

  GetPopupMessageUseCase(this.repository);

  Future<Either<Failure, PopupMessage>> call() async {
    return await repository.getPopupMessage();
  }
}
