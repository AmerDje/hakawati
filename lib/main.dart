//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/service/service_locator.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_state.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';
import 'package:hakawati/features/settings/presentation/views/onboarding/onboarding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'config/locale/locale.dart';
import 'core/utils/cache/prefs.dart';
import 'core/utils/strings.dart';

import 'features/home/presentation/home.dart';
import 'config/theme/theme.dart';
import 'features/settings/presentation/views/localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  ServicesLocator.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsCubit(platformBrightness: WidgetsBinding.instance.platformDispatcher.platformBrightness),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingState>(
      buildWhen: (previous, current) => previous != current,
      builder: (_, settings) {
        return MaterialApp(
          title: Strings.appName,
          locale: Locale(settings.locate),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          home: _getWidget(settings),
        );
      },
    );
  }

  Widget _getWidget(SettingState state) {
    if (state.enableTranslation) {
      return const ChangeLanguageView();
    } else if (state.enableOnBoarding) {
      return const OnboardingScreen();
    } else {
      return const HomeView();
    }
  }
}
