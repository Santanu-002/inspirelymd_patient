import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/entities/refill_request.dart';

abstract interface class IPharmacyRepository {
  Future<Either<AppFailure, void>> requestRefill(RefillRequest request);
}
