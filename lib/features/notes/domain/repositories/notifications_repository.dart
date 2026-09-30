import 'package:flutter/material.dart';

abstract class INotificationsRepository {
  /// Id used by the daily reminder notification, todo reminders use ids
  /// derived from their reminder id so the two never clash.
  static const int dailyReminderNotificationId = 0;

  /// Schedules daily notification at [time]
  Future<void> zonedScheduleNotification(TimeOfDay time);

  /// Schedules a one-shot notification at [dateTime] (used by todo reminders)
  Future<void> scheduleOneTimeNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  });

  /// Cancels a single scheduled notification
  Future<void> cancelNotification(int id);

  /// True when notifications can be shown and exact alarms are allowed
  Future<bool> areNotificationsEnabled();

  /// Requests notification + exact alarm permissions, returns grant status
  Future<bool> requestPermission();

  /// Cancels/removes all notifications that have been scheduled and those
  /// that have already been presented.
  Future<void> cancelAllNotifications();
}
