import 'package:flutter/services.dart';

import '../../constants/constants.dart';

abstract class ICheckConnectivityService {
  Stream<bool> get connectivityStream;
}

class CheckConnectivityService implements ICheckConnectivityService {
  static const EventChannel _eventChannel = EventChannel(kConnectivityEventChannel);
  Stream<bool>? _connectivityStream;

  CheckConnectivityService() {
    _connectivityStream = _eventChannel.receiveBroadcastStream().map((event) => event as bool);
  }

  @override
  Stream<bool> get connectivityStream => _connectivityStream!;
}
