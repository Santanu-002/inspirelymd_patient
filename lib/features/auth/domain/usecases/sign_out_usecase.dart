import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';

class SignOutUseCase implements BaseUseCase<void, NoParams> {
  final IAuthRepository _repository;

  SignOutUseCase(this._repository);

  @override
  Future<Either<AppFailure, void>> call(NoParams params) {
    return _repository.signOut();
  }
}
