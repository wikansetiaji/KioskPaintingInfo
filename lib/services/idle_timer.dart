import 'dart:async';
import 'package:flutter/material.dart';

class IdleTimer {
  final Duration timeout;
  final VoidCallback onTimeout;

  Timer? _timer;

  IdleTimer({required this.timeout, required this.onTimeout});

  void reset() {
    _timer?.cancel();
    _timer = Timer(timeout, onTimeout);
  }

  void dispose() {
    _timer?.cancel();
  }
}
