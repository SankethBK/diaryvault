import 'dart:convert';

import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String body(List<Map<String, dynamic>> ops) => jsonEncode(ops);

  group("parseTodosFromDeltaJson", () {
    test("extracts unchecked and checked todo lines", () {
      final todos = parseTodosFromDeltaJson(body([
        {"insert": "buy milk"},
        {
          "insert": "\n",
          "attributes": {"list": "unchecked"}
        },
        {"insert": "call mom"},
        {
          "insert": "\n",
          "attributes": {"list": "checked"}
        },
      ]));

      expect(todos.length, 2);
      expect(todos[0].text, "buy milk");
      expect(todos[0].isChecked, isFalse);
      expect(todos[0].reminderId, isNull);
      expect(todos[1].text, "call mom");
      expect(todos[1].isChecked, isTrue);
    });

    test("ignores non-todo lines but keeps bullets and numbers out", () {
      final todos = parseTodosFromDeltaJson(body([
        {"insert": "plain paragraph"},
        {"insert": "\n"},
        {"insert": "bullet"},
        {
          "insert": "\n",
          "attributes": {"list": "bullet"}
        },
        {"insert": "numbered"},
        {
          "insert": "\n",
          "attributes": {"list": "ordered"}
        },
      ]));

      expect(todos, isEmpty);
    });

    test("attaches reminder embed data to the todo line", () {
      final reminderData = encodeTodoReminderData(id: "abc-123", time: 1000);
      final todos = parseTodosFromDeltaJson(body([
        {"insert": "water plants"},
        {
          "insert": {
            "custom": jsonEncode({kTodoReminderEmbedType: reminderData})
          }
        },
        {
          "insert": "\n",
          "attributes": {"list": "unchecked"}
        },
      ]));

      expect(todos.length, 1);
      expect(todos[0].text, "water plants");
      expect(todos[0].reminderId, "abc-123");
      expect(todos[0].reminderAt, 1000);
    });

    test("applies list attributes to every newline in a text op", () {
      final todos = parseTodosFromDeltaJson(body([
        {
          "insert": "first\nsecond\n",
          "attributes": {"list": "unchecked"}
        },
      ]));

      expect(todos.map((todo) => todo.text), ["first", "second"]);
      expect(todos.every((todo) => !todo.isChecked), isTrue);
    });

    test("skips todo lines that became empty", () {
      final todos = parseTodosFromDeltaJson(body([
        {
          "insert": "\n",
          "attributes": {"list": "unchecked"}
        },
      ]));

      expect(todos, isEmpty);
    });

    test("returns empty for invalid json bodies (e.g. ciphertext)", () {
      expect(parseTodosFromDeltaJson("not a delta"), isEmpty);
      expect(parseTodosFromDeltaJson('{"ops": []}'), isEmpty);
    });

    test("ignores malformed todo-reminder embeds", () {
      final todos = parseTodosFromDeltaJson(body([
        {"insert": "task"},
        {
          "insert": {
            "custom": jsonEncode({kTodoReminderEmbedType: "garbage"})
          }
        },
        {
          "insert": "\n",
          "attributes": {"list": "unchecked"}
        },
      ]));

      expect(todos.length, 1);
      expect(todos[0].reminderId, isNull);
    });
  });
}
