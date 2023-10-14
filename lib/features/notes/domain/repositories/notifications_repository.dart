import 'package:flutter/material.dart';

abstract class INotificationsRepository {
  /// Schedules daily notification at [time]
  Future<void> zonedScheduleNotification(TimeOfDay time);
}
