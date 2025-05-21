import 'dart:async';

import 'package:flutter/material.dart';

class Throttler {
  static Throttler to = Throttler();

  Timer? _timer;

  VoidCallback run({required VoidCallback action, Duration? duration}) {
    return () {
      if (_timer == null || !_timer!.isActive) {
        action();
        _timer = Timer(duration ?? const Duration(milliseconds: 300), () {});
      }
    };
  }
}
