import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class IDebouncerService {
  final int milliseconds;

  IDebouncerService({required this.milliseconds});

  void run(VoidCallback action);
}

class DebouncerService implements IDebouncerService {
  @override
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DebouncerService({this.milliseconds = 500});

  @override
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
