import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';

abstract interface class IDashboardRepository {
  Future<Either<AppFailure, List<Map<String, dynamic>>>> getAppointments();
  Future<Either<AppFailure, List<Map<String, dynamic>>>> getPrescriptions();
  Future<Either<AppFailure, List<Map<String, dynamic>>>> getVitals();
  Future<Either<AppFailure, void>> saveAppointment(
    Map<String, dynamic> appointment,
  );
  Future<Either<AppFailure, void>> saveVitals(Map<String, dynamic> vitals);
}
