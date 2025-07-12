import 'dart:async';

class EventBus {
  static final StreamController<String> _controller =
      StreamController<String>.broadcast();

  static Stream<String> get stream => _controller.stream;

  static void send(String message) {
    _controller.add(message);
  }
}
