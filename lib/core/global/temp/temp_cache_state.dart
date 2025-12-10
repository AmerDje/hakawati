part of 'temp_cache_cubit.dart';

class TempCacheState extends Equatable {
  const TempCacheState({
    this.stores = const {},
  });

  final Map<String, Equatable> stores;

  TempCacheState copyWith({
    required String key,
    required Equatable store,
  }) {
    Map<String, Equatable> stores = Map<String, Equatable>.of(this.stores);
    stores[key] = store;
    return TempCacheState(
      stores: stores,
    );
  }

  @override
  List<Object> get props => [stores];
}
