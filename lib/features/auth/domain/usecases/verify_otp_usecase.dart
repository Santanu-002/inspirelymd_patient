import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';

class VerifyOtpUseCase
    implements BaseUseCase<Map<String, dynamic>, VerifyOtpParams> {
  final IAuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> call(
    VerifyOtpParams params,
  ) {
    return _repository.verifyOtp(
      countryCode: params.countryCode,
      phoneNumber: params.phoneNumber,
      otp: params.otp,
    );
  }
}

class VerifyOtpParams {
  final String countryCode;
  final String phoneNumber;
  final String otp;

  const VerifyOtpParams({
    required this.countryCode,
    required this.phoneNumber,
    required this.otp,
  });
}
