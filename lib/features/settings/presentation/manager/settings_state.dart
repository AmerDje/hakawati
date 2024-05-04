import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hakawati/core/utils/constants.dart';

class SettingState extends Equatable {
  final String locate;
  final ThemeMode themeMode;
  final bool enableOnBoarding;
  final bool enableTranslation;

  const SettingState({
    required this.locate,
    required this.themeMode,
    this.enableOnBoarding = false,
    this.enableTranslation = false,
  });

  static const SettingState empty = SettingState(
    locate: Constants.kDefaultLocale,
    themeMode: ThemeMode.system,
    enableOnBoarding: false,
    enableTranslation: false,
  );

  factory SettingState.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  SettingState copyWith({
    String? locate,
    ThemeMode? themeMode,
    bool? enableOnBoarding,
    bool? enableTranslation,
  }) {
    return SettingState(
      locate: locate ?? this.locate,
      themeMode: themeMode ?? this.themeMode,
      enableOnBoarding: enableOnBoarding ?? this.enableOnBoarding,
      enableTranslation: enableTranslation ?? this.enableTranslation,
    );
  }

  @override
  List<Object> get props => [
        locate,
        themeMode,
        enableOnBoarding,
        enableTranslation,
      ];
}

SettingState _$SettingFromJson(Map<String, dynamic> json) => SettingState(
      locate: json['locate'] as String,
      themeMode: ThemeMode.values[json['themeMode'] as int],
      enableOnBoarding: (json['enableOnBoarding'] ?? false) as bool,
      enableTranslation: (json['enableTranslation'] ?? false) as bool,
    );

Map<String, dynamic> _$SettingToJson(SettingState instance) => <String, dynamic>{
      'locate': instance.locate,
      'themeMode': instance.themeMode.index,
      'enableOnBoarding': instance.enableOnBoarding,
      'enableTranslation': instance.enableTranslation,
    };
