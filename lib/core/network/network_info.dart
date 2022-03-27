import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Takes [InternetConnectionChecker] as DI and returns true if we are connected to internet
/// otherwise returns false
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  const NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;

  @override
  List<Object?> get props => [];
}
