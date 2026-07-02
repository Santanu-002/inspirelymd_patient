import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/datasources/i_pharmacy_datasource.dart';
import 'package:inspirelymd_patient/features/pharmacy/data/models/refill_request_model.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/entities/refill_request.dart';
import 'package:inspirelymd_patient/features/pharmacy/domain/repositories/i_pharmacy_repository.dart';

class PharmacyRepositoryImpl implements IPharmacyRepository {
  final IPharmacyDataSource _dataSource;

  PharmacyRepositoryImpl(this._dataSource);

  @override
  Future<Either<AppFailure, void>> requestRefill(RefillRequest request) async {
    try {
      final model = RefillRequestModel.fromEntity(request);
      await _dataSource.requestRefill(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
