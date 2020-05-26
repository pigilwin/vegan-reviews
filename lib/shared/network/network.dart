import 'package:connectivity/connectivity.dart';

mixin Network {
  Future<bool> hasNetworkAccess() async {
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }
}