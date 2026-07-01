import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/events/app_event.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/repositories/i_event_bus_repository.dart';

class FireEventUseCase implements BaseUseCase<void, AppEvent> {
  final IEventBusRepository _repository;

  FireEventUseCase(this._repository);

  @override
  Future<Either<AppFailure, void>> call(AppEvent params) async {
    _repository.fire(params);
    return right(null);
  }
}
