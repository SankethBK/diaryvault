import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  const Failure({required this.message, required this.code});

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return "Error $code: $message";
  }
}
