import 'package:inspirelymd_patient/core/common/events/app_event.dart';
import 'package:inspirelymd_patient/core/common/models/auth_tokens/auth_tokens.dart';

class SessionExpiredEvent extends AppEvent {
  const SessionExpiredEvent();
}

class AuthTokensUpdatedEvent extends AppEvent {
  final AuthTokens tokens;
  const AuthTokensUpdatedEvent(this.tokens);
}
