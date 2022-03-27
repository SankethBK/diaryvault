import 'package:equatable/equatable.dart';

class LoggedInUser extends Equatable {
  final String email;
  final String id;

  const LoggedInUser({required this.email, required this.id});

  @override
  List<Object?> get props => [email, id];
}
