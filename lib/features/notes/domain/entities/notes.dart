import 'package:equatable/equatable.dart';

class Notes extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String body;

  Notes({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, createdAt, title, body];
}
