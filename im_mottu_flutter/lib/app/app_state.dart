// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'shared/services/theme/theme_app_state.dart';

class AppState {
  final ThemeAppState themeState;
  final bool hasConnection;

  AppState({
    required this.themeState,
    required this.hasConnection,
  });

  static AppState empty() => AppState(themeState: ThemeAppState.initState(), hasConnection: false);

  AppState copyWith({
    ThemeAppState? themeState,
    bool? hasConnection,
  }) {
    return AppState(
      themeState: themeState ?? this.themeState,
      hasConnection: hasConnection ?? this.hasConnection,
    );
  }
}
