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

  tz.TZDateTime nextInstanceOfTime(TimeOfDay time, tz.Location localTimeZOne) {
    final tz.TZDateTime now = tz.TZDateTime.now(localTimeZOne);

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
      final permissionsEnabled = await areNotificationsEnabled();

      log.w("permissions enabled = $permissionsEnabled");

      if (!permissionsEnabled) {
        // We can request permission from within the App for >= Android 13
        final arePermissionsGranted = await requestPermission();
        if (!arePermissionsGranted) {
          throw Exception("Notification permissions are not enabled");
        }
      }

      // inititalize time zones
      tz.initializeTimeZones();
      final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName!));

      log.i("Local timezone = ${tz.local}");

      // cancel all previously scheduled notifications before scheduling new ones
      cancelAllNotifications();

      await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Time to Journal!',
          'Take a few minutes to reflect on your day in your diary',
          nextInstanceOfTime(time, tz.local),
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

  Future<bool> areNotificationsEnabled() async {
    final bool granted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
    return granted;
  }

  Future<bool> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool grantedNotificationPermission =
        await androidImplementation?.requestNotificationsPermission() ?? false;

    return grantedNotificationPermission;
  }

  @override
  Future<void> cancelAllNotifications() async {
    log.i("Cancelling all scheduled notifications");
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
