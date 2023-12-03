import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum NoteSortType {
  sortByLatestFirst("sortByLatestFirst"),
  sortByOldestFirst("sortByOldestFirst"),
  sortByAtoZ("sortByAtoZ");

  const NoteSortType(this.text);
  factory NoteSortType.fromStringValue(String stringValue) {
    switch (stringValue) {
      case 'sortByLatestFirst':
        return NoteSortType.sortByLatestFirst;
      case 'sortByOldestFirst':
        return NoteSortType.sortByOldestFirst;
      case 'sortByAtoZ':
        return NoteSortType.sortByAtoZ;
      default:
        throw Exception('Invalid NoteSortType value: $stringValue');
    }
  }
  final String text;
}

/// class to store non-critical properties of user
/// it is stored apart from user table, which stores critical properties of user
class UserConfigModel extends Equatable {
  final String userId;
  final String? preferredSyncOption;
  final DateTime? lastGoogleDriveSync;
  final DateTime? lastDropboxSync;
  final String? googleDriveUserInfo;
  final String? dropBoxUserInfo;
  final bool? isAutoSyncEnabled;
  final bool? isFingerPrintLoginEnabled;
  final bool? isPINLoginEnabled;
  final bool? isAutoSaveEnabled;
  final bool? isDailyReminderEnabled;
  final TimeOfDay? reminderTime;
  final NoteSortType? noteSortType;
  final String? nextCloudUserInfo;
  final DateTime? lastNextCloudSync;

  const UserConfigModel({
    required this.userId,
    this.preferredSyncOption,
    this.lastGoogleDriveSync,
    this.lastDropboxSync,
    this.googleDriveUserInfo,
    this.dropBoxUserInfo,
    this.isAutoSyncEnabled,
    this.isFingerPrintLoginEnabled,
    this.isPINLoginEnabled,
    this.isAutoSaveEnabled,
    this.isDailyReminderEnabled,
    this.reminderTime,
    this.noteSortType,
    this.nextCloudUserInfo,
    this.lastNextCloudSync,
  });
  @override
  List<Object?> get props => [
        userId,
        preferredSyncOption,
        lastGoogleDriveSync,
        lastDropboxSync,
        googleDriveUserInfo,
        dropBoxUserInfo,
        isAutoSyncEnabled,
        isFingerPrintLoginEnabled,
        isPINLoginEnabled,
        isAutoSaveEnabled,
        isDailyReminderEnabled,
        reminderTime,
        noteSortType,
        nextCloudUserInfo,
        lastNextCloudSync
      ];

  static TimeOfDay? getTimeOfDayFromTimeString(String? timeString) {
    if (timeString != null) {
      final parts = timeString.split(':');

      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      }

      return null;
    }
    return null;
  }

  static String? getTimeOfDayToString(TimeOfDay? time) {
    if (time == null) {
      return null;
    }

    final hour = time.hour.toString();
    final minute = time.minute.toString();
    final formattedHour = hour.length == 1 ? hour.padLeft(2, '0') : hour;
    final formattedMinute =
        minute.length == 1 ? minute.padLeft(2, '0') : minute;

    return '$formattedHour:$formattedMinute';
  }

  factory UserConfigModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserConfigModel(
      userId: jsonMap[UserConfigConstants.userId],
      preferredSyncOption: jsonMap[UserConfigConstants.preferredSyncOption],
      lastGoogleDriveSync:
          jsonMap[UserConfigConstants.lastGoogleDriveSync] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  jsonMap[UserConfigConstants.lastGoogleDriveSync])
              : null,
      lastDropboxSync: jsonMap[UserConfigConstants.lastDropboxSync] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              jsonMap[UserConfigConstants.lastDropboxSync])
          : null,
      googleDriveUserInfo: jsonMap[UserConfigConstants.googleDriveUserInfo],
      dropBoxUserInfo: jsonMap[UserConfigConstants.dropBoxUserInfo],
      isAutoSyncEnabled: jsonMap[UserConfigConstants.isAutoSyncEnabled],
      isFingerPrintLoginEnabled:
          jsonMap[UserConfigConstants.isFingerPrintLoginEnabled],
      isPINLoginEnabled: jsonMap[UserConfigConstants.isPINLoginEnabled],
      isAutoSaveEnabled: jsonMap[UserConfigConstants.isAutoSaveEnabled],
      isDailyReminderEnabled:
          jsonMap[UserConfigConstants.isDailyReminderEnabled],
      reminderTime:
          getTimeOfDayFromTimeString(jsonMap[UserConfigConstants.reminderTime]),
      noteSortType: jsonMap[UserConfigConstants.noteSortType] != null
          ? NoteSortType.fromStringValue(
              jsonMap[UserConfigConstants.noteSortType])
          : null,
      nextCloudUserInfo: jsonMap[UserConfigConstants.nextCloudUserInfo],
      lastNextCloudSync: jsonMap[UserConfigConstants.lastNextCloudSync] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              jsonMap[UserConfigConstants.lastNextCloudSync])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserConfigConstants.userId: userId,
      UserConfigConstants.preferredSyncOption: preferredSyncOption,
      UserConfigConstants.lastGoogleDriveSync:
          lastGoogleDriveSync?.millisecondsSinceEpoch,
      UserConfigConstants.lastDropboxSync:
          lastDropboxSync?.millisecondsSinceEpoch,
      UserConfigConstants.googleDriveUserInfo: googleDriveUserInfo,
      UserConfigConstants.dropBoxUserInfo: dropBoxUserInfo,
      UserConfigConstants.isAutoSyncEnabled: isAutoSyncEnabled,
      UserConfigConstants.isFingerPrintLoginEnabled: isFingerPrintLoginEnabled,
      UserConfigConstants.isPINLoginEnabled: isPINLoginEnabled,
      UserConfigConstants.isAutoSaveEnabled: isAutoSaveEnabled,
      UserConfigConstants.isDailyReminderEnabled: isDailyReminderEnabled,
      UserConfigConstants.reminderTime: getTimeOfDayToString(reminderTime),
      UserConfigConstants.noteSortType: noteSortType?.text,
      UserConfigConstants.nextCloudUserInfo: nextCloudUserInfo,
      UserConfigConstants.lastNextCloudSync:
          lastNextCloudSync?.millisecondsSinceEpoch,
    };
  }
}
