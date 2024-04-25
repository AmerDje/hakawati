import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/cache/prefs.dart';
import 'package:hakawati/core/utils/strings.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(_getDefaultLocale());

  Locale get currentLocale => state;

  Future<void> loadLocale() async {
    try {
      String languageCode = Prefs.getString(Strings.locale) ?? Strings.englishCode;
      emit(Locale(languageCode));
    } catch (_) {}
  }

  Future<void> setLocale(Locale locale) async {
    try {
      await Prefs.setString(Strings.locale, locale.languageCode);
      emit(locale);
    } catch (_) {}
  }

  static Locale _getDefaultLocale() {
    String languageCode = Prefs.getString(Strings.locale) ?? Strings.englishCode;
    return Locale(languageCode);
  }
}
