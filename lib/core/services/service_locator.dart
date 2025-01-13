import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show WidgetsBinding;
import 'package:get_it/get_it.dart';
import 'package:hakawati/core/global/temp/temp_cache_cubit.dart';
import 'package:hakawati/core/services/dio_consumer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hakawati/core/services/connectivity_checker.dart';
import 'package:hakawati/core/services/firebase_auth_service.dart';
import 'package:hakawati/core/services/firebase_firestore_service.dart';
import 'package:hakawati/core/services/firebase_storage_service.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';
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
    // Firebase sl
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

    // Service sl
    sl.registerLazySingleton<FirebaseFireStoreService>(() => FirebaseFireStoreService());
    sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    sl.registerLazySingleton<FirebaseStorageService>(() => FirebaseStorageService());

    // Repository sl
    // Auth Repo sl
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          fireStoreService: sl.get<FirebaseFireStoreService>(),
          firebaseAuthService: sl.get<FirebaseAuthService>(),
          firebaseStorageService: sl.get<FirebaseStorageService>(),
        ));

    // Cubit sl
    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl.get<AuthRepositoryImpl>()));
    sl.registerFactory<TempCacheCubit>(() => TempCacheCubit());
    sl.registerFactory<SettingsCubit>(
        () => SettingsCubit(platformBrightness: WidgetsBinding.instance.platformDispatcher.platformBrightness));
    sl.registerFactory<AuthCubit>(() => AuthCubit()); //authRepositoryImpl: sl.get<AuthRepositoryImpl>()));
  }
}
