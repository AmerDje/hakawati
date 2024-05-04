import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hakawati/core/api/dio_consumer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hakawati/core/network/connectivity_checker.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    sl.registerLazySingleton<DioConsumer>(() => DioConsumer(sl.get<Dio>(), sl.get<ConnectivityCheckerImpl>()));
    sl.registerLazySingleton<ConnectivityCheckerImpl>(() => ConnectivityCheckerImpl(connectivity: Connectivity()));
    sl.registerLazySingleton<Dio>(() => Dio());
  }
}
