import 'dart:convert';

import 'package:dairy_app/core/logger/logger.dart';

final log = printer("TodoDeltaParser");

/// Custom embed type used to attach a one-shot reminder to a todo line
const String kTodoReminderEmbedType = 'todo-reminder';
const String kTodoReminderActionEmbedType = 'todo-reminder-action';

/// Encodes the payload stored inside a todo reminder embed
String encodeTodoReminderData({required String id, required int time}) =>
    jsonEncode({"id": id, "time": time});

/// Decodes the payload of a todo reminder embed, null when malformed
Map<String, dynamic>? decodeTodoReminderData(String data) {
  try {
    final decoded = jsonDecode(data);
    if (decoded is Map<String, dynamic> &&
        decoded["id"] is String &&
        decoded["time"] is int) {
      return decoded;
    }
  } catch (_) {}
  return null;
}

/// A todo line found in a note's delta body
class ParsedTodo {
  final String text;
  final bool isChecked;

  /// id of the reminder embed on this line (stable across saves)
  final String? reminderId;

  /// epoch millis of the reminder
  final int? reminderAt;

  const ParsedTodo({
    required this.text,
    required this.isChecked,
    this.reminderId,
    this.reminderAt,
  });
}

/// Parses a quill delta json body and extracts all check-list lines
/// together with any reminder embeds attached to them.
///
/// Quill stores block attributes on newline characters. If an insert op
/// contains multiple newlines, its attributes apply to each of them.
List<ParsedTodo> parseTodosFromDeltaJson(String bodyJson) {
  final todos = <ParsedTodo>[];

  List<dynamic> ops;
  try {
    ops = jsonDecode(bodyJson) as List<dynamic>;
  } catch (e) {
    log.w("todo parse skipped, body is not a delta list: $e");
    return todos;
  }

  final buffer = StringBuffer();
  String? reminderId;
  int? reminderAt;

  void flushLine(Map<String, dynamic>? attrs) {
    final listAttr = attrs?["list"];
    if (listAttr == "checked" || listAttr == "unchecked") {
      final text = buffer.toString().trim();
      if (text.isNotEmpty) {
        todos.add(ParsedTodo(
          text: text,
          isChecked: listAttr == "checked",
          reminderId: reminderId,
          reminderAt: reminderAt,
        ));
      }
    }
    buffer.clear();
    reminderId = null;
    reminderAt = null;
  }

  for (final op in ops) {
    if (op is! Map) continue;
    final insert = op["insert"];
    final attrs = op["attributes"] as Map<String, dynamic>?;

    if (insert is String) {
      final parts = insert.split("\n");
      for (var i = 0; i < parts.length; i++) {
        buffer.write(parts[i]);
        if (i < parts.length - 1) {
          // Every newline in an insert op has that op's attributes.
          flushLine(attrs);
        }
      }
    } else if (insert is Map) {
      // Older builds stored the reminder directly as an embeddable type.
      final directReminder = insert[kTodoReminderEmbedType];
      if (directReminder is String) {
        final data = decodeTodoReminderData(directReminder);
        if (data != null) {
          reminderId = data["id"] as String;
          reminderAt = data["time"] as int;
        }
      }

      final custom = insert["custom"];
      if (custom is String) {
        try {
          final embeddable = jsonDecode(custom);
          if (embeddable is Map &&
              embeddable.length == 1 &&
              embeddable.containsKey(kTodoReminderEmbedType)) {
            final data = decodeTodoReminderData(
                embeddable[kTodoReminderEmbedType] as String);
            if (data != null) {
              reminderId = data["id"] as String;
              reminderAt = data["time"] as int;
            }
          }
        } catch (_) {}
      }
      // other embeds (image/video/audio) do not contribute text
    }
  }

  return todos;
}
