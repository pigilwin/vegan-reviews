import 'package:connectivity/connectivity.dart';

mixin Network {
  Future<bool> hasNoNetworkAccess() async {
    return await Connectivity().checkConnectivity() == ConnectivityResult.none;
  }
}