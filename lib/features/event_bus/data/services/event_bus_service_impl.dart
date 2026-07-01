import 'dart:async';
import 'package:inspirelymd_patient/core/common/events/app_event.dart';
import 'package:inspirelymd_patient/features/event_bus/data/services/i_event_bus_service.dart';

class EventBusServiceImpl implements IEventBusService {
  final _controller = StreamController<AppEvent>.broadcast();

  @override
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  @override
  void fire(AppEvent event) {
    _controller.add(event);
  }
}
