import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const GlobalState()) {
    on<GlobalStoreChanged>(_onStoreChanged);
  }

  void _onStoreChanged(GlobalStoreChanged event, Emitter<GlobalState> emit) {
    emit(state.copyWith(
      key: event.key,
      store: event.store,
    ));
  }
}
