import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/utils/cache/prefs.dart';

import 'config/theme/theme.dart';
import 'features/home/presentation/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(platformBrightness: View.of(context).platformDispatcher.platformBrightness),
      child: Builder(builder: (context) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, themeMode) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              home: const HomeView(),
            );
          },
        );
      }),
    );
  }
}
