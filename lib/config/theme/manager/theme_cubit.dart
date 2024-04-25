import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/cache/prefs.dart';
import 'package:hakawati/core/utils/strings.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Brightness? platformBrightness;

  ThemeCubit({this.platformBrightness}) : super(_getTheme());

  bool get isDarkMode {
    if (state == ThemeMode.system && platformBrightness != null) {
      return platformBrightness == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }

  void toggleTheme({required bool isToggled}) {
    if (isToggled) {
      emit(ThemeMode.dark);
      Prefs.setString(Strings.appTheme, Strings.dark);
    } else {
      emit(ThemeMode.light);
      Prefs.setString(Strings.appTheme, Strings.light);
    }
  }

  static ThemeMode _getTheme() {
    final String? savedThemeString = Prefs.getString(Strings.appTheme);
    if (savedThemeString != null) {
      return savedThemeString == Strings.dark ? ThemeMode.dark : ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
