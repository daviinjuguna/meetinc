import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ThemeState { light, dark, lightContrast, darkContrast, system }

class ThemeCubit extends HydratedCubit<ThemeState> {
  static const defaultTheme = ThemeState.system;
  ThemeCubit() : super(defaultTheme);

  @override
  ThemeState? fromJson(Map<String, dynamic> json) =>
      ThemeState.values[json['value']];

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'value': state.index,
      };

  ThemeState get theme => state;
  set theme(ThemeState themeState) => emit(themeState);

  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
      case ThemeState.lightContrast:
        return ThemeMode.light;
      case ThemeState.dark:
      case ThemeState.darkContrast:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Default light theme
  ThemeData? get lightTheme => state == ThemeState.light
      ? _themeData[ThemeState.light]
      : _themeData[ThemeState.lightContrast];

  /// Default dark theme
  ThemeData? get darkTheme => state == ThemeState.dark
      ? _themeData[ThemeState.dark]
      : _themeData[ThemeState.darkContrast];
}

final Map<ThemeState, ThemeData> _themeData = {
  ThemeState.light: ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(),
  ),
  ThemeState.dark: ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(),
  ),
  ThemeState.lightContrast: ThemeData.light().copyWith(
    colorScheme: const ColorScheme.highContrastLight(),
  ),
  ThemeState.darkContrast: ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.highContrastDark(),
  )
};
