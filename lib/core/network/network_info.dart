import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoIpm implements NetworkInfo{
  final DataConnectionChecker connectionChecker;

  NetworkInfoIpm(this.connectionChecker);

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;

}