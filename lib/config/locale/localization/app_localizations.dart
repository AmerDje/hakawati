import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'app_localizations_delegate.dart';

class AppLocalizations {
  // localization variables
  final Locale locale;
  late Map<String, String> localizedStrings;
  static RegExp exp = RegExp(r"\{(.*?)\}");

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  // constructor
  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<String> _loadAssets(String languageCode) async {
    try {
      return await rootBundle.loadString('assets/lang/$languageCode.json');
    } catch (_) {
      return await rootBundle.loadString('assets/lang/en.json');
    }
  }

  // This is a helper method that will load local specific strings from file
  // present in lang folder
  Future<bool> load() async {
    String jsonString = await _loadAssets(locale.languageCode);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString().replaceAll(r"\'", "'").replaceAll(r"\t", " "));
    });

    return true;
  }

  static String replace(txt, Map<String, String?> options) => txt.replaceAllMapped(exp, (Match m) {
        if (options.isEmpty) return m.group(0) ?? '';
        if (m.group(0) == null || m.group(1) == null) return '';
        return options[m.group(1)] ?? m.group(0) ?? '';
      });

  // This method will be called from every widget which needs a localized text
  String translate(String key, [Map<String, String?>? options]) {
    String? txt = localizedStrings[key];
    if (txt == null || txt.isEmpty) {
      return key;
    }

    if (options == null || options.isEmpty) {
      return txt;
    }

    return replace(txt, options);
  }
}
