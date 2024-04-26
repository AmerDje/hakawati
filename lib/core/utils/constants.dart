import 'package:hakawati/features/settings/data/entities/onboarding_entity.dart';

const kTransitionDuration = Duration(milliseconds: 250);
const kWinterDrink = 'Winter Drink';
const kQuicksand = 'Quicksand';

const List<OnboardingEntity> kOnboardingData = <OnboardingEntity>[
  OnboardingEntity(
    title: 'Welcome to the app!',
    description: 'Discover new stories from around the world',
    image: 'assets/images/onboarding1.png',
  ),
  OnboardingEntity(
    title: 'Share your own stories',
    description: 'Join our community of storytellers and share your own stories',
    image: 'assets/images/onboarding2.png',
  ),
  OnboardingEntity(
    title: 'Get started',
    description: 'Sign up now to start exploring and sharing stories',
    image: 'assets/images/onboarding3.png',
  ),
];
