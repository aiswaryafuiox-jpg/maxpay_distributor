import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/data/model/popup_message_mode.dart';

abstract class PopupMessageRepository {
  Future<Either<Failure, PopupMessage>> getPopupMessage();
}
