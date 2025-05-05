import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasConnection() async {
  final c = await Connectivity().checkConnectivity();
  return !c.contains(ConnectivityResult.none) && c.isNotEmpty;
}
