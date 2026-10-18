import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AuthSessionExpiredHandler = Future<void> Function();

class AuthSessionEvents {
  AuthSessionExpiredHandler? _onSessionExpired;

  void registerSessionExpiredHandler(AuthSessionExpiredHandler handler) {
    _onSessionExpired = handler;
  }

  void unregisterSessionExpiredHandler() {
    _onSessionExpired = null;
  }

  Future<void> notifySessionExpired() async {
    final handler = _onSessionExpired;

    if (handler != null) {
      await handler();
    }
  }
}

final authSessionEventsProvider = Provider<AuthSessionEvents>((ref) {
  final events = AuthSessionEvents();

  ref.onDispose(events.unregisterSessionExpiredHandler);

  return events;
});
