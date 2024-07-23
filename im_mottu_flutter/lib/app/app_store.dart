import 'dart:async';

import 'package:get/get.dart';

import 'app_state.dart';
import 'shared/services/connectivity/check_connectivity_service.dart';
import 'shared/services/theme/theme_app_state.dart';
import 'shared/services/theme/theme_app_store.dart';

class AppStore extends GetxController {
  final ThemeAppStore themeAppStore;
  final ICheckConnectivityService checkConnectivityService;
  late StreamSubscription<bool> _subscription;

  AppState state = AppState.empty();

  AppStore(this.themeAppStore, this.checkConnectivityService);

  Future<void> getThemeApp() async {
    themeAppStore.getThemeApp();
  }

  void changeTheme(ThemeEnum theme) {
    themeAppStore.changeTheme(theme);
  }

  void updateTheme(ThemeAppState themeState) {
    state = state.copyWith(themeState: themeState);
    update();
  }

  void initCheckConnectivity() {
    _subscription = checkConnectivityService.connectivityStream.listen((connected) {
      state = state.copyWith(hasConnection: connected);
      update();
    });
  }

  void cancelConnectivitySubscription() {
    _subscription.cancel();
    
  }
}
