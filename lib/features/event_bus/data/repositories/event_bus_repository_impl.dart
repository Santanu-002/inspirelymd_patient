import 'package:inspirelymd_patient/core/common/events/app_event.dart';
import 'package:inspirelymd_patient/features/event_bus/data/services/i_event_bus_service.dart';
import 'package:inspirelymd_patient/features/event_bus/domain/repositories/i_event_bus_repository.dart';

class EventBusRepositoryImpl implements IEventBusRepository {
  final IEventBusService _service;

  EventBusRepositoryImpl(this._service);

  @override
  Stream<T> on<T extends AppEvent>() {
    return _service.on<T>();
  }

  @override
  void fire(AppEvent event) {
    _service.fire(event);
  }
}
