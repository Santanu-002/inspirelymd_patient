import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/core/services/database/database_service.dart';
import 'package:inspirelymd_patient/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  final DatabaseService _dbService;

  DashboardRepositoryImpl(this._dbService);

  @override
  Future<Either<AppFailure, List<Map<String, dynamic>>>>
  getAppointments() async {
    try {
      final list = await _dbService.getAppointments();
      return right(list);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Map<String, dynamic>>>>
  getPrescriptions() async {
    try {
      final list = await _dbService.getPrescriptions();
      return right(list);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<Map<String, dynamic>>>> getVitals() async {
    try {
      final list = await _dbService.getVitals();
      return right(list);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> saveAppointment(
    Map<String, dynamic> appointment,
  ) async {
    try {
      final db = await _dbService.database;
      await db.insert('appointments', appointment);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> saveVitals(
    Map<String, dynamic> vitals,
  ) async {
    try {
      final db = await _dbService.database;
      await db.insert('vitals', vitals);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
