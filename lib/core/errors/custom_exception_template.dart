import 'package:equatable/equatable.dart';

/// Each [CustomException] has a [code] and [meesage]
///
/// if [code] is -1, it means code is not important and exception is self explanatory
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
