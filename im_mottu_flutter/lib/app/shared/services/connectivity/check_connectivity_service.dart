import 'package:flutter/services.dart';

import '../../constants/constants.dart';

abstract class ICheckConnectivityService {
  Stream<bool> get connectivityStream;
  bool get checkConnectivitySnapshot;
}

class CheckConnectivityService implements ICheckConnectivityService {
  static const EventChannel _eventChannel = EventChannel(kConnectivityEventChannel);
  Stream<bool>? _connectivityStream;
  bool hasConnect = false;

  CheckConnectivityService() {
    _connectivityStream = _eventChannel.receiveBroadcastStream().map((event) {
      hasConnect = event as bool;
      return hasConnect;
    });
  }

  @override
  Stream<bool> get connectivityStream => _connectivityStream!;

  @override
  bool get checkConnectivitySnapshot => hasConnect;
}
