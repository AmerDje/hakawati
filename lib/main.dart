import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/localization/localization.dart';
import 'core/utils/cache/prefs.dart';
import 'core/utils/strings.dart';

import 'config/theme/theme.dart';
import 'features/home/presentation/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(platformBrightness: WidgetsBinding.instance.window.platformBrightness),
        ),
        BlocProvider(
          create: (_) => LocalizationCubit()..loadLocale(),
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (_, themeMode) {
        return BlocBuilder<LocalizationCubit, Locale>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, local) {
            return MaterialApp(
              title: Strings.appName,
              locale: local,
              debugShowCheckedModeBanner: false,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              home: const HomeView(),
            );
          },
        );
      },
    );
  }
}
