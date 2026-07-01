import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';

class SendOtpUseCase implements BaseUseCase<String, SendOtpParams> {
  final IAuthRepository _repository;

  SendOtpUseCase(this._repository);

  @override
  Future<Either<AppFailure, String>> call(SendOtpParams params) {
    return _repository.sendOtp(
      countryCode: params.countryCode,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SendOtpParams {
  final String countryCode;
  final String phoneNumber;

  const SendOtpParams({
    required this.countryCode,
    required this.phoneNumber,
  });
}
