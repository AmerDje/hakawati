import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/cache/prefs.dart';
import 'package:hakawati/core/utils/strings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial);

  closeOnBoarding() async {
    await Prefs.setBool(Strings.isOnboardingClosed, true);
    emit(state.copyWith(isOnboardingClosed: true));
  }

  closeTranslation() async {
    await Prefs.setBool(Strings.isLanguageSelected, true);
    emit(state.copyWith(isLanguageSelected: true));
  }
}
