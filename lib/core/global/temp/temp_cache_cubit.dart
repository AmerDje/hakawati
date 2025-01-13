import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'temp_cache_state.dart';

class TempCacheCubit extends Cubit<TempCacheState> {
  TempCacheCubit() : super(const TempCacheState());
  void onStoreChanged(
    final String key,
    final Equatable store,
  ) {
    emit(state.copyWith(
      key: key,
      store: store,
    ));
  }
}
