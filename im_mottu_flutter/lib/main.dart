import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'app/injector.dart';
import 'app/shared/services/analytics/crashalytics_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CrashlyticsService.initializeCrashlytics();
  injector.commit();
  runApp(
    const AppWidget(),
  );
}
