import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/entities/refill_request.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/repositories/i_pharmacy_repository.dart';

class RequestRefillUseCase implements BaseUseCase<void, RefillRequest> {
  final IPharmacyRepository _repository;

  RequestRefillUseCase(this._repository);

  @override
  Future<Either<AppFailure, void>> call(RefillRequest params) {
    return _repository.requestRefill(params);
  }
}
