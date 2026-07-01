import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class GetAppointmentsUseCase implements BaseUseCase<List<Map<String, dynamic>>, NoParams> {
  final IDashboardRepository _repository;

  GetAppointmentsUseCase(this._repository);

  @override
  Future<Either<AppFailure, List<Map<String, dynamic>>>> call(NoParams params) {
    return _repository.getAppointments();
  }
}
