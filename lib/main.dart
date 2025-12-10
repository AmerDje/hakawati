import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/global/temp/temp_cache_cubit.dart';
import 'package:hakawati/core/services/app_bloc_observer.dart';
import 'package:hakawati/core/services/service_locator.dart';
import 'package:hakawati/features/auth/auth.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/view/widgets/email_verification_screen.dart';
import 'package:hakawati/features/bottom_navbar/presentation/view/bottom_navbar_view.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_state.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';
import 'package:hakawati/features/settings/presentation/views/onboarding/onboarding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'config/locale/locale.dart';
import 'core/services/prefs.dart';
import 'core/utils/strings.dart';

import 'config/theme/theme.dart';
import 'features/settings/presentation/views/localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Prefs.init();
  ServicesLocator.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  Bloc.observer = AppBlocObserver(
    filteredBlocs: [
      TempCacheCubit,
      SettingsCubit,
    ],
    isLoggingEnabled: false,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TempCacheCubit>(create: (_) => sl.get<TempCacheCubit>()),
        BlocProvider<SettingsCubit>(
          create: (_) => sl.get<SettingsCubit>(),
        ),
        BlocProvider<AuthCubit>(create: (_) => sl.get<AuthCubit>()),
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
          localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (_, authState) {
              return _getWidget(settings, authState);
            },
          ),
        );
      },
    );
  }

  Widget _getWidget(SettingState state, AuthState authState) {
    if (state.enableTranslation) {
      return const ChangeLanguageView();
    } else if (state.enableOnBoarding) {
      return const OnboardingScreen();
    } else if (authState.status == AuthStatus.unauthenticated ||
        authState.status == AuthStatus.unknown) {
      return const LoginView();
    } else if (authState.user.emailVerified != true) {
      return BlocProvider(
        create: (context) => sl.get<RegisterCubit>()..sendEmailVerification(),
        child: EmailVerificationScreen(
          email: authState.user.email ?? '',
          password: authState.user.password ?? '',
        ),
      );
    } else {
      return const BottomNavbarView();
    }
  }
}
