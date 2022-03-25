import 'package:equatable/equatable.dart';

class LoggedInUser extends Equatable {
  final String email;
  final String password;

  const LoggedInUser({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
