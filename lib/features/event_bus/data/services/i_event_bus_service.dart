import 'package:inspirelymd_patient/core/common/events/app_event.dart';

abstract interface class IEventBusService {
  Stream<T> on<T extends AppEvent>();
  void fire(AppEvent event);
}
