import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class SaveAppointmentUseCase implements BaseUseCase<void, SaveAppointmentParams> {
  final IDashboardRepository _repository;

  SaveAppointmentUseCase(this._repository);

  @override
  Future<Either<AppFailure, void>> call(SaveAppointmentParams params) {
    return _repository.saveAppointment(params.appointment);
  }
}

class SaveAppointmentParams {
  final Map<String, dynamic> appointment;

  const SaveAppointmentParams({required this.appointment});
}
