import 'package:firebase_analytics/firebase_analytics.dart';

abstract class IAnalyticsService {
  Future<void> logEvent(String value, Map<String, Object>? parameters);
}

class AnalyticsService implements IAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String value, Map<String, Object>? parameters) async {
    await _analytics.logEvent(
      name: value,
      parameters: parameters,
    );
  }
}
