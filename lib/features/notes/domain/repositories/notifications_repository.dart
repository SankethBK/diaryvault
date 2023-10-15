import 'package:flutter/material.dart';

abstract class INotificationsRepository {
  /// Schedules daily notification at [time]
  Future<void> zonedScheduleNotification(TimeOfDay time);

  /// Cancels/removes all notifications that have been scheduled and those
  /// that have already been presented.
  Future<void> cancelAllNotifications();
}
