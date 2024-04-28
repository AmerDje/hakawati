import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hakawati/core/api/dio_consumer.dart';
import 'package:hakawati/core/network/connectivity_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    sl.registerLazySingleton<DioConsumer>(() => DioConsumer(Dio(), sl.get<InternetConnectionImpl>()));
    sl.registerLazySingleton<InternetConnectionImpl>(
        () => InternetConnectionImpl(connectionChecker: InternetConnectionChecker()));
  }
}
