import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/bloc_observer.dart';
import 'package:hakawati/core/service/service_locator.dart';
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
import 'core/utils/cache/prefs.dart';
import 'core/utils/strings.dart';

import 'config/theme/theme.dart';
import 'features/settings/presentation/views/localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  ServicesLocator.init();
  await Firebase.initializeApp();

  Bloc.observer = AppBlocObserver();
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     //apply logout logic
  //     print('User is currently signed out!');
  //   } else {
  //     user.getIdToken();
  //     //update token logic
  //     print('User is signed in!');
  //   }
  // });
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsCubit(platformBrightness: WidgetsBinding.instance.platformDispatcher.platformBrightness),
        ),
        BlocProvider(create: (_) => AuthCubit()),
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
          home: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => previous.status != current.status,
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
    } else if (authState.status == AuthStatus.unauthenticated || authState.status == AuthStatus.unknown) {
      return const LoginView();
    } else if (authState.status == AuthStatus.authenticated && authState.user.emailVerified == true) {
      return const BottomNavbarView();
    } else {
      return BlocProvider(
        create: (context) => sl.get<RegisterCubit>()..sendEmailVerification(),
        child: EmailVerificationScreen(
          email: authState.user.email ?? '',
        ),
      );
    }
  }
}
