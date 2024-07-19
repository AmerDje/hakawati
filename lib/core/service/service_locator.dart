import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show WidgetsBinding;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hakawati/core/api/dio_consumer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hakawati/core/common/global/bloc/global_bloc.dart';
import 'package:hakawati/core/network/connectivity_checker.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    //Dio sl
    sl.registerLazySingleton<DioConsumer>(() => DioConsumer(sl.get<Dio>(), sl.get<ConnectivityCheckerImpl>()));
    sl.registerLazySingleton<ConnectivityCheckerImpl>(() => ConnectivityCheckerImpl(connectivity: Connectivity()));
    sl.registerLazySingleton<Dio>(() => Dio());

    // Auth sl
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
    sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);

    // Repository sl
    sl.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(
        firebaseAuth: sl.get<FirebaseAuth>(),
        firebaseFirestore: sl.get<FirebaseFirestore>(),
        googleSignIn: sl.get<GoogleSignIn>(),
        facebookAuth: sl.get<FacebookAuth>()));

    // Cubit sl
    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl.get<AuthRepositoryImpl>()));
    sl.registerFactory<GlobalBloc>(() => GlobalBloc());
    sl.registerFactory<SettingsCubit>(
        () => SettingsCubit(platformBrightness: WidgetsBinding.instance.platformDispatcher.platformBrightness));
    sl.registerFactory<AuthCubit>(() => AuthCubit());
  }
}
