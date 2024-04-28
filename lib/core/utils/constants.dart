import 'package:hakawati/features/settings/data/entities/onboarding_entity.dart';

const kTransitionDuration = Duration(milliseconds: 250);

const kBaseUrl = 'https://hakawati-api.herokuapp.com/api/v1';
const kWinterDrink = 'Winter Drink';
const kQuicksand = 'Quicksand';
const kLalezar = 'Lalezar';
const kMarhey = 'Marhey';
const kDefaultLocale = 'en';
const kSupportedLanguages = ['en', 'ar', 'fr'];

const List<OnboardingEntity> kOnboardingData = <OnboardingEntity>[
  OnboardingEntity(
    title: 'title_1',
    description: 'description_1',
    image: 'assets/images/onboarding1.png',
  ),
  OnboardingEntity(
    title: 'title_2',
    description: 'description_2',
    image: 'assets/images/onboarding2.png',
  ),
  OnboardingEntity(
    title: 'title_3',
    description: 'description_3',
    image: 'assets/images/onboarding3.png',
  ),
];
