import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity? connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<ConnectivityResult> get isConnected =>  connectivity!.checkConnectivity();
}
