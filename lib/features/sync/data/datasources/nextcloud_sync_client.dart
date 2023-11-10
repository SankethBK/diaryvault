import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:webdav_client/webdav_client.dart';

final log = printer("NextCloudSyncClient");

class NextCloudSyncClient extends ISyncClient {
  @override
  Future<void> signIn() async {
    log.i("Starting signIn");

    final isSignedIn = await this.isSignedIn();

    log.i("isSignedIn = $isSignedIn");
  }

  @override
  Future<bool> createFolder(String folderName,
      {String? parentFolder, String? fullFolderPath}) {
    // TODO: implement createFolder
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteFile(String fileName,
      {bool folder = false, String? fullFilePath}) {
    // TODO: implement deleteFile
    throw UnimplementedError();
  }

  @override
  Future<String> downloadFile(String fileName,
      {bool outputAsFile = false, String? fullFilePath}) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<DateTime?> getNoteCreatedTime(String fileName,
      {bool folder = false, String? fullFilePath}) {
    // TODO: implement getNoteCreatedTime
    throw UnimplementedError();
  }

  @override
  Future<String?> getSignedInUserInfo() {
    // TODO: implement getSignedInUserInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> initialieClient() {
    // TODO: implement initialieClient
    throw UnimplementedError();
  }

  @override
  Future<bool> isFilePresent(String fileName,
      {bool folder = false, String? fullFilePath}) {
    // TODO: implement isFilePresent
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() async {
    const host =
        "https://efss.qloud.my/remote.php/dav/files/pinkbatman7777@gmail.com/";
    const email = "pinkbatman7777@gmail.com";
    const password = "mqwQ7gjTM@rL6Z9";

    var client = newClient(
      host,
      user: email,
      password: password,
      debug: true,
    );

    try {
      client.ping();

      log.i("Existing configuration is valid");
    } catch (e) {
      log.e(e);
      rethrow;
    }

    return false;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<bool> updateFile(
      {required String fileName,
      required String fileContent,
      required String fullFilePath}) {
    // TODO: implement updateFile
    throw UnimplementedError();
  }

  @override
  Future<void> updateLastSynced() {
    // TODO: implement updateLastSynced
    throw UnimplementedError();
  }

  @override
  Future<bool> uploadFile(
      {String? fileContent,
      String? fileName,
      File? file,
      String? fullFilePath,
      required String parentFolder}) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }
}
