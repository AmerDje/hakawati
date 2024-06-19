import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/features/settings/data/entities/onboarding_entity.dart';

abstract class Constants {
  static const kTransitionDuration = Duration(milliseconds: 250);

  static const kBaseUrl = 'https://hakawati-api.herokuapp.com/api/v1';
  static const kWinterDrink = 'Winter Drink';
  static const kQuicksand = 'Quicksand';
  static const kLalezar = 'Lalezar';
  static const kMarhey = 'Marhey';
  static const kDefaultLocale = 'en';
  static const kSupportedLanguages = ['en', 'ar', 'fr'];

  static const Map<String, String> kLanguages = {
    'en': 'English',
    'ar': 'Arabic',
    'fr': 'French',
  };

  static const List<OnboardingEntity> kOnboardingData = <OnboardingEntity>[
    OnboardingEntity(
      title: 'title_1',
      description: 'description_1',
      image: Assets.onboardingOne,
    ),
    OnboardingEntity(
      title: 'title_2',
      description: 'description_2',
      image: Assets.onboardingTwo,
    ),
    OnboardingEntity(
      title: 'title_3',
      description: 'description_3',
      image: Assets.onboardingThree,
    ),
  ];

  static const List<BoxShadow> initShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, -5),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> secondaryShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      offset: Offset(0, 0),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> thirdShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, 5),
      blurRadius: 15,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> forthShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 95, 255, 0.15),
      offset: Offset(0, 9),
      blurRadius: 9,
      spreadRadius: 0,
    ),
  ];

  static const kCircularRadius12 = BorderRadius.all(Radius.circular(12));

  static const kCircularRadius8 = BorderRadius.all(Radius.circular(8));

  static const kCircularRadius6 = BorderRadius.all(Radius.circular(6));
}
