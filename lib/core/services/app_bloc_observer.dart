import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/functions/logger.dart';

class AppBlocObserver extends BlocObserver {
  /// Enables filtering of logs for specific Blocs by their runtime type.
  final List<Type> filteredBlocs;

  /// Controls whether logging is globally enabled.
  final bool isLoggingEnabled;

  AppBlocObserver({this.filteredBlocs = const [], this.isLoggingEnabled = true});

  @override
  void onChange(BlocBase bloc, Change change) {
    if (!isLoggingEnabled || _isFiltered(bloc.runtimeType)) return;

    final location = _extractLocation(StackTrace.current);
    final buffer = StringBuffer()
      ..writeln('--- Bloc State Change ---')
      ..writeln('Time: ${DateTime.now()}')
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..writeln('Triggered by: $location')
      ..writeln('Current State: ${change.currentState}')
      //    ..writeln('Next State: ${change.nextState}')
      ..writeln('--------------------------');

    avoidLog(buffer);
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (!isLoggingEnabled || _isFiltered(bloc.runtimeType)) return;

    avoidLog('${bloc.runtimeType}: Event -> $event, name: Bloc Event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (!isLoggingEnabled || _isFiltered(bloc.runtimeType)) return;

    avoidLog('${bloc.runtimeType}: Transition -> $transition, name: Bloc Transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (!isLoggingEnabled || _isFiltered(bloc.runtimeType)) return;

    final location = _extractLocation(stackTrace);
    avoidLog('${bloc.runtimeType}: Error -> $error\nTriggered at: $location, name: Bloc Error');
    super.onError(bloc, error, stackTrace);
  }

  bool _isFiltered(Type blocType) => filteredBlocs.contains(blocType);

  String _extractLocation(StackTrace stackTrace) {
    final stackLines = stackTrace.toString().trim().split('\n');
    stackLines.retainWhere(
      (element) => element.contains('package:akakus_leave_ease'),
    );

    if (stackLines.isNotEmpty) {
      return stackLines.last.trim();
    }
    return 'Unknown Location';
  }
  /* @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc.runtimeType.toString() != 'TempCacheCubit' && bloc.runtimeType.toString() != 'TabsCubit') {
      avoidPrint('${bloc.runtimeType} $transition');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc.runtimeType.toString() != 'TempCacheCubit' && bloc.runtimeType.toString() != 'TabsCubit') {
      avoidPrint('${bloc.runtimeType} $change');
    }
  }*/
}
