part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  static const initial = SettingsState._(
    isLanguageSelected: false,
    isOnboardingClosed: false,
  );

  final bool isLanguageSelected;
  final bool isOnboardingClosed;

  const SettingsState._({
    required this.isLanguageSelected,
    required this.isOnboardingClosed,
  });

  SettingsState copyWith({
    bool? isLanguageSelected,
    bool? isOnboardingClosed,
  }) {
    return SettingsState._(
      isLanguageSelected: isLanguageSelected ?? this.isLanguageSelected,
      isOnboardingClosed: isOnboardingClosed ?? this.isOnboardingClosed,
    );
  }

  @override
  List<Object?> get props => [isLanguageSelected, isOnboardingClosed];
}
