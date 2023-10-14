import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final bool? isAutoSaveEnabled;
  final bool? isDailyReminderEnabled;
  final TimeOfDay? reminderTime;

  const UserConfigModel({
    required this.userId,
    this.preferredSyncOption,
    this.lastGoogleDriveSync,
    this.lastDropboxSync,
    this.googleDriveUserInfo,
    this.dropBoxUserInfo,
    this.isAutoSyncEnabled,
    this.isFingerPrintLoginEnabled,
    this.isAutoSaveEnabled,
    this.isDailyReminderEnabled,
    this.reminderTime,
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
        isAutoSaveEnabled,
        isDailyReminderEnabled,
        reminderTime
      ];

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
      isAutoSaveEnabled: jsonMap[UserConfigConstants.isAutoSaveEnabled],
      isDailyReminderEnabled:
          jsonMap[UserConfigConstants.isDailyReminderEnabled],
      reminderTime: jsonMap[UserConfigConstants.reminderTime] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(
              "1970-01-01 ${jsonMap[UserConfigConstants.reminderTime]}:00"))
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
      UserConfigConstants.isAutoSaveEnabled: isAutoSaveEnabled,
      UserConfigConstants.isDailyReminderEnabled: isDailyReminderEnabled,
      UserConfigConstants.reminderTime: reminderTime != null
          ? '${reminderTime!.hour}:${reminderTime!.minute}'
          : null
    };
  }
}
