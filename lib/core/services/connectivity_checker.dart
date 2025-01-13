import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityChecker {
  Future<bool> get isConnected;
}

class ConnectivityCheckerImpl implements ConnectivityChecker {
  final Connectivity _connectivity;

  ConnectivityCheckerImpl({required Connectivity connectivity}) : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
