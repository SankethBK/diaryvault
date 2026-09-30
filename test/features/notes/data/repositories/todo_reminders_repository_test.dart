import 'package:dairy_app/features/notes/data/repositories/todo_reminders_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('notificationIdForReminder', () {
    test('is stable and positive for a reminder ID', () {
      expect(notificationIdForReminder('rem-1'), 1289541373);
      expect(
        notificationIdForReminder('rem-1'),
        notificationIdForReminder('rem-1'),
      );
      expect(notificationIdForReminder('rem-1'), greaterThan(0));
    });

    test('maps distinct reminder IDs to their deterministic values', () {
      expect(notificationIdForReminder('rem-2'), isNot(1289541373));
    });
  });
}
