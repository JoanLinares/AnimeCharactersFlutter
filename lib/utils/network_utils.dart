import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasConnection() async {
  try {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none) && result.isNotEmpty;
  } catch (e) {
    // Handle exceptions
    return false;
  }
}
