import 'package:equatable/equatable.dart';

abstract class CustomException extends Equatable implements Exception {
  final String message;
  final int code;

  const CustomException({required this.message, required this.code});

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return "Exception $code: $message";
  }
}
