import 'package:flutter/material.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hakawati/core/utils/constants.dart';

class SettingsCubit extends HydratedCubit<SettingState> {
  final Brightness platformBrightness;
  SettingsCubit({required this.platformBrightness})
      : super(const SettingState(
          locate: kDefaultLocale,
          themeMode: ThemeMode.system,
          enableOnBoarding: false,
          enableTranslation: true,
        ));

  bool get isDarkMode {
    if (state.themeMode == ThemeMode.system) {
      return platformBrightness == Brightness.dark;
    }
    return state.themeMode == ThemeMode.dark;
  }

  void closeOnBoarding() {
    emit(state.copyWith(enableOnBoarding: false));
  }

  void closeTranslation() {
    emit(state.copyWith(enableOnBoarding: true, enableTranslation: false));
  }

  void changeLanguage(String locate) {
    emit(state.copyWith(locate: locate));
  }

  void toggleTheme() {
    ThemeMode themeMode = (state.themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: themeMode));
  }

  @override
  SettingState? fromJson(Map<String, dynamic> json) {
    return SettingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    return state.toJson();
  }
}
