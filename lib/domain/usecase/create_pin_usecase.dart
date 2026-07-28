import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import '../../data/model/create_pin_response_model.dart';
import '../repository/login_sendOtp_repo.dart';

class CreatePinUseCase {
  final LoginRepository repository;

  CreatePinUseCase(this.repository);

  Future<Either<Failure, CreatePinResponseModel>> call(String pin) async {
    return await repository.createPin(pin);
  }
}
