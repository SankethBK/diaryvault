import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final log = printer("NotificationsRepository");

class NotificationsRepository implements INotificationsRepository {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationsRepository({required this.flutterLocalNotificationsPlugin});

  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  tz.TZDateTime nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    log.i("Scheduling alarm at $scheduledDate");
    return scheduledDate;
  }

  @override
  Future<void> zonedScheduleNotification(TimeOfDay time) async {
    try {
      initializeTimeZone();

      // cancel all previously scheduled notifications before scheduling new ones
      cancelAllNotifications();

      log.i("Local timezone = ${tz.local}");

      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Time to Journal!',
          'Take a moment for yourself. Write your thoughts, dreams, and experiences in your journal today.',
          nextInstanceOfTime(time),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_reminder',
              'Daily reminders',
              importance: Importance.high,
              channelDescription: 'Daily Reminder Notifications',
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    log.i("Cancelling all scheduled notifications");
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
