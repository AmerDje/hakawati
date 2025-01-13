import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' show WidgetsBinding;
import 'package:get_it/get_it.dart';
import 'package:hakawati/core/functions/logger.dart';
import 'package:hakawati/core/global/temp/temp_cache_cubit.dart';
import 'package:hakawati/core/services/dio_consumer.dart';
import 'package:hakawati/core/services/firebase_auth_service.dart';
import 'package:hakawati/core/services/firebase_firestore_service.dart';
import 'package:hakawati/core/services/firebase_storage_service.dart';
import 'package:hakawati/core/utils/constants.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/auth/presentation/views/register/manager/register_cubit.dart';
import 'package:hakawati/features/settings/presentation/manager/settings_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    //Dio sl
    sl.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: Constants.kBaseUrl,
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          connectTimeout: const Duration(milliseconds: 60000),
          receiveTimeout: const Duration(milliseconds: 60000),
        ),
      )..interceptors.add(LogInterceptor(
          error: false,
          logPrint: (error) => avoidPrint(error),
          request: false,
          requestBody: true,
          requestHeader: true,
          responseHeader: false,
          responseBody: true,
        )),
    );

    sl.registerLazySingleton<DioConsumer>(() => DioConsumer(sl.get<Dio>()));
    // Auth sl
    // Firebase sl
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

    // Service sl
    sl.registerLazySingleton<FirebaseFireStoreService>(() => FirebaseFireStoreService(
          firestore: sl.get<FirebaseFirestore>(),
        ));
    sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService(
          firebaseAuth: sl.get<FirebaseAuth>(),
        ));
    sl.registerLazySingleton<FirebaseStorageService>(() => FirebaseStorageService(
          firebaseStorage: sl.get<FirebaseStorage>(),
        ));

    // Repository sl
    // Auth Repo sl
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          fireStoreService: sl.get<FirebaseFireStoreService>(),
          firebaseAuthService: sl.get<FirebaseAuthService>(),
          firebaseStorageService: sl.get<FirebaseStorageService>(),
        ));

    // Cubit sl
    sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl.get<AuthRepository>()));
    sl.registerFactory<TempCacheCubit>(() => TempCacheCubit());
    sl.registerFactory<SettingsCubit>(
        () => SettingsCubit(platformBrightness: WidgetsBinding.instance.platformDispatcher.platformBrightness));
    sl.registerFactory<AuthCubit>(() => AuthCubit());
  }
}
