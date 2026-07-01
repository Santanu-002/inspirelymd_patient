import 'package:inspirelymd_patient/core/common/events/app_event.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/repositories/i_event_bus_repository.dart';

class OnEventUseCase {
  final IEventBusRepository _repository;

  OnEventUseCase(this._repository);

  Stream<T> call<T extends AppEvent>() {
    return _repository.on<T>();
  }
}
