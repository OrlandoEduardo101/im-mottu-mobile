import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/app_store.dart';

import 'injector.dart';
import 'routers.dart';
import 'shared/services/theme/theme_app_state.dart';
import 'shared/services/theme/theme_app_store.dart';
// import 'routes.dart.bak';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final ThemeAppStore themeStore = injector.get<ThemeAppStore>();
  final AppStore appStore = injector.get<AppStore>();
  double topPositioned = 0;
  @override
  void initState() {
    super.initState();
    appStore.initCheckConnectivity();
    appStore.getThemeApp();
    themeStore.addListener(() {
      appStore.updateTheme(themeStore.value);
    });
  }

  @override
  void dispose() {
    appStore.cancelConnectivitySubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = const Color(0xff33ff00);
    Brightness selectedBrightness = Brightness.light;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GetMaterialApp.router(
      title: 'Mottu-Marvel',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        seedColor: selectedColor,
        brightness: selectedBrightness,
      )),
      builder: (context, child) => GetBuilder<AppStore>(
        init: appStore,
        builder: (controller) {
          if (!controller.state.hasConnection) {
            topPositioned = kToolbarHeight + 20;
          } else {
            topPositioned = 0;
          }
          return Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                seedColor: selectedColor,
                brightness:
                    controller.state.themeState.theme == ThemeEnum.lightTheme ? Brightness.light : Brightness.dark,
              )),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  child ?? const SizedBox.shrink(),
                  AnimatedPositioned(
                    top: topPositioned,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      opacity: controller.state.hasConnection ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'You are offline',
                          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onError),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
      routeInformationParser: Routers.router.routeInformationParser,
      routerDelegate: Routers.router.routerDelegate,
      routeInformationProvider: Routers.router.routeInformationProvider,
    );
  }
}
