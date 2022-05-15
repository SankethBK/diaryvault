import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String body;
  final String hash;
  final DateTime lastModified;
  final String plainText;
  final List<Map<String, String>> assetDependencies;

  const Note({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.hash,
    required this.lastModified,
    required this.plainText,
    required this.assetDependencies,
  });

  @override
  List<Object?> get props => [id];
}
