import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class SaveVitalsUseCase implements BaseUseCase<void, SaveVitalsParams> {
  final IDashboardRepository _repository;

  SaveVitalsUseCase(this._repository);

  @override
  Future<Either<AppFailure, void>> call(SaveVitalsParams params) {
    return _repository.saveVitals(params.vitals);
  }
}

class SaveVitalsParams {
  final Map<String, dynamic> vitals;

  const SaveVitalsParams({required this.vitals});
}
