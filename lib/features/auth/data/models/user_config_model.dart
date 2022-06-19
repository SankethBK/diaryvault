import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:equatable/equatable.dart';

/// class to store non-critical properties of user
/// it is stored apart from user table, which stores critical properties of user
class UserConfigModel extends Equatable {
  final String userId;
  final String? preferredSyncOption;
  final DateTime? lastGoogleDriveSync;
  final DateTime? lastDropboxSync;
  final String? googleDriveUserInfo;
  final String? dropBoxUserInfo;

  const UserConfigModel({
    required this.userId,
    this.preferredSyncOption,
    this.lastGoogleDriveSync,
    this.lastDropboxSync,
    this.googleDriveUserInfo,
    this.dropBoxUserInfo,
  });

  @override
  List<Object?> get props => [
        userId,
        preferredSyncOption,
        lastGoogleDriveSync,
        lastDropboxSync,
        googleDriveUserInfo,
        dropBoxUserInfo
      ];

  factory UserConfigModel.fromJson(Map<String, dynamic> jsonMap) {
    return UserConfigModel(
      userId: jsonMap[UserConfidConstants.userId],
      preferredSyncOption: jsonMap[UserConfidConstants.preferredSyncOption],
      lastGoogleDriveSync: jsonMap[UserConfidConstants.lastGoogleDriveSync],
      lastDropboxSync: jsonMap[UserConfidConstants.lastDropboxSync],
      googleDriveUserInfo: jsonMap[UserConfidConstants.googleDriveUserInfo],
      dropBoxUserInfo: jsonMap[UserConfidConstants.dropBoxUserInfo],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserConfidConstants.userId: userId,
      UserConfidConstants.preferredSyncOption: preferredSyncOption,
      UserConfidConstants.lastGoogleDriveSync: lastGoogleDriveSync,
      UserConfidConstants.lastDropboxSync: lastDropboxSync,
      UserConfidConstants.googleDriveUserInfo: googleDriveUserInfo,
      UserConfidConstants.dropBoxUserInfo: dropBoxUserInfo,
    };
  }
}
