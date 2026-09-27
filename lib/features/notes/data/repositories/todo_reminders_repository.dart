import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/todos_local_data_source.dart';
import 'package:dairy_app/features/notes/data/models/todo_item_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/notifications_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/todo_reminders_repository.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:uuid/uuid.dart';

final log = printer("TodoRemindersRepository");

/// Deterministic notification id for a reminder embed; 0 is reserved for
/// the daily reminder.
int notificationIdForReminder(String reminderId) {
  // Dart's String.hashCode is not stable across app runs. Keep this hash
  // deterministic so scheduled notifications can be cancelled after restart.
  var hash = 0x811C9DC5;
  for (final codeUnit in reminderId.codeUnits) {
    hash ^= codeUnit;
    hash = (hash * 0x01000193) & 0xFFFFFFFF;
  }
  final id = hash & 0x7FFFFFFF;
  return id == INotificationsRepository.dailyReminderNotificationId ? 1 : id;
}

class TodoRemindersRepository implements ITodoRemindersRepository {
  final ITodosLocalDataSource todosLocalDataSource;
  final INotificationsRepository notificationsRepository;

  TodoRemindersRepository({
    required this.todosLocalDataSource,
    required this.notificationsRepository,
  });

  @override
  Future<void> syncTodosForNote({
    required String noteId,
    required String noteTitle,
    required String body,
    required bool isEncrypted,
  }) async {
    try {
      // encrypted notes never leak todo content into the todos table or
      // into notification text
      if (isEncrypted) {
        await purgeRemindersForNotes([noteId]);
        return;
      }

      final parsed = parseTodosFromDeltaJson(body);
      final oldTodos = await todosLocalDataSource.getForNote(noteId);
      final oldById = {for (final t in oldTodos) t.id: t};
      final usedNotificationIds = <int>{};

      final now = DateTime.now().millisecondsSinceEpoch;
      final newTodos = <TodoItemModel>[];

      for (var i = 0; i < parsed.length; i++) {
        final todo = parsed[i];

        if (todo.reminderId == null || todo.reminderAt == null) {
          newTodos.add(TodoItemModel(
            id: "$noteId-$i",
            noteId: noteId,
            noteTitle: noteTitle,
            text: todo.text,
            isChecked: todo.isChecked,
          ));
          continue;
        }

        final reminderId = todo.reminderId!;
        final reminderAt = todo.reminderAt!;
        final notificationId = notificationIdForReminder(reminderId);

        final old = oldById[reminderId];
        final isFuture = reminderAt > now;
        final unchanged = old != null &&
            old.reminderAt == reminderAt &&
            old.text == todo.text &&
            old.notificationId == notificationId &&
            !todo.isChecked &&
            !old.isChecked;

        if (isFuture && !todo.isChecked) {
          usedNotificationIds.add(notificationId);
          if (!unchanged) {
            // new reminder, rescheduled time or edited text
            await notificationsRepository.scheduleOneTimeNotification(
              id: notificationId,
              title: S.current.todoReminderNotificationTitle,
              body: todo.text,
              dateTime: DateTime.fromMillisecondsSinceEpoch(reminderAt),
            );
          }
        }

        newTodos.add(TodoItemModel(
          id: reminderId,
          noteId: noteId,
          noteTitle: noteTitle,
          text: todo.text,
          isChecked: todo.isChecked,
          reminderAt: reminderAt,
          notificationId:
              isFuture && !todo.isChecked ? notificationId : null,
        ));
      }

      // cancel notifications whose todo was checked, deleted, or whose
      // reminder embed was removed
      for (final old in oldTodos) {
        final notifId = old.notificationId;
        if (notifId == null || usedNotificationIds.contains(notifId)) {
          continue;
        }
        await notificationsRepository.cancelNotification(notifId);
      }

      await todosLocalDataSource.replaceForNote(noteId, newTodos);
    } catch (e) {
      // todo tracking must never break note saving
      log.e("sync failed for note $noteId: $e");
    }
  }

  @override
  Future<void> purgeRemindersForNotes(List<String> noteIds) async {
    try {
      for (final noteId in noteIds) {
        final todos = await todosLocalDataSource.getForNote(noteId);
        for (final todo in todos) {
          if (todo.notificationId != null) {
            await notificationsRepository.cancelNotification(
                todo.notificationId!);
          }
        }
      }
      await todosLocalDataSource.deleteForNotes(noteIds);
    } catch (e) {
      log.e("purge failed for notes $noteIds: $e");
    }
  }

  @override
  Future<List<TodoItemModel>> getAllOpenTodos() async {
    final todos = await todosLocalDataSource.getAllTodos();
    return todos.where((todo) => !todo.isChecked).toList();
  }

  @override
  Future<List<TodoItemModel>> getAllTodos() =>
      todosLocalDataSource.getAllTodos();

  @override
  Future<void> setStandaloneTodoChecked(String id, bool isChecked) async {
    final todos = await todosLocalDataSource.getAllTodos();
    TodoItemModel? todo;
    for (final item in todos) {
      if (item.id == id && item.noteId == null) {
        todo = item;
        break;
      }
    }
    if (todo == null) throw StateError('Standalone todo not found');

    int? notificationId;
    if (isChecked) {
      if (todo.notificationId != null) {
        await notificationsRepository.cancelNotification(todo.notificationId!);
      }
    } else if (todo.reminderAt != null &&
        todo.reminderAt! > DateTime.now().millisecondsSinceEpoch) {
      notificationId =
          todo.notificationId ?? notificationIdForReminder(todo.id);
      await notificationsRepository.scheduleOneTimeNotification(
        id: notificationId,
        title: S.current.todoReminderNotificationTitle,
        body: todo.text,
        dateTime: DateTime.fromMillisecondsSinceEpoch(todo.reminderAt!),
      );
    }

    await todosLocalDataSource.setStandaloneTodoChecked(
      id,
      isChecked,
      notificationId,
    );
  }

  @override
  Future<void> createStandaloneTodo(String text,
      {DateTime? reminderAt}) async {
    final id = const Uuid().v4();
    final notificationId =
        reminderAt == null ? null : notificationIdForReminder(id);
    if (reminderAt != null) {
      if (!reminderAt.isAfter(DateTime.now())) {
        throw ArgumentError('Reminder must be in the future');
      }
      await notificationsRepository.scheduleOneTimeNotification(
        id: notificationId!,
        title: S.current.todoReminderNotificationTitle,
        body: text.trim(),
        dateTime: reminderAt,
      );
    }

    try {
      await todosLocalDataSource.insertStandaloneTodo(TodoItemModel(
        id: id,
        noteTitle: '',
        text: text.trim(),
        isChecked: false,
        reminderAt: reminderAt?.millisecondsSinceEpoch,
        notificationId: notificationId,
      ));
    } catch (_) {
      if (notificationId != null) {
        await notificationsRepository.cancelNotification(notificationId);
      }
      rethrow;
    }
  }

  @override
  Future<void> updateStandaloneTodo(
    TodoItemModel todo, {
    required String text,
    required DateTime? reminderAt,
  }) async {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) {
      throw ArgumentError('Todo text cannot be empty');
    }
    final reminderWasUnchanged =
        todo.reminderAt == reminderAt?.millisecondsSinceEpoch;
    if (reminderAt != null &&
        !reminderAt.isAfter(DateTime.now()) &&
        !reminderWasUnchanged) {
      throw ArgumentError('Reminder must be in the future');
    }

    final shouldSchedule = !todo.isChecked &&
        reminderAt != null &&
        reminderAt.isAfter(DateTime.now());
    final notificationId = shouldSchedule
        ? (todo.notificationId ?? notificationIdForReminder(todo.id))
        : null;
    if (shouldSchedule) {
      await notificationsRepository.scheduleOneTimeNotification(
        id: notificationId!,
        title: S.current.todoReminderNotificationTitle,
        body: normalizedText,
        dateTime: reminderAt,
      );
    }

    await todosLocalDataSource.updateStandaloneTodo(TodoItemModel(
      id: todo.id,
      noteId: null,
      noteTitle: '',
      text: normalizedText,
      isChecked: todo.isChecked,
      reminderAt: reminderAt?.millisecondsSinceEpoch,
      notificationId: notificationId,
    ));

    if (!shouldSchedule && todo.notificationId != null) {
      await notificationsRepository.cancelNotification(todo.notificationId!);
    }
  }
}
