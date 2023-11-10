import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:webdav_client/webdav_client.dart' as webdavClient;

final log = printer("NextCloudSyncClient");

class NextCloudSyncClient extends ISyncClient {
  late webdavClient.Client client;

  @override
  Future<void> signIn() async {
    log.i("Starting signIn");

    final isSignedIn = await this.isSignedIn();

    log.i("isSignedIn = $isSignedIn");
  }

  @override
  Future<bool> createFolder(String folderName,
      {String? parentFolder, String? fullFolderPath}) async {
    log.i("creating folder $folderName in $fullFolderPath");

    try {
      fullFolderPath = fullFolderPath ?? "/$folderName";

      await client.mkdir(fullFolderPath);

      log.i("Created $folderName in $fullFolderPath");
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    try {
      log.i("deleting $fullFilePath");

      fullFilePath = fullFilePath ?? "/$fileName";

      await client.remove(fullFilePath);

      log.i("Deleted $fullFilePath");
      return true;
    } catch (e) {
      log.e(e);
      rethrow;
    }
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
  Future<bool> initialieClient() async {
    await signIn();
    return true;
  }

  @override
  Future<bool> isFilePresent(
    String fileName, {
    bool folder = false,
    String? fullFilePath,
  }) async {
    try {
      log.i("Searching for $fileName file");

      // if file path is not passed, we assume it is present in root folder
      fullFilePath = fullFilePath ?? "/$fileName";

      await client.read(fullFilePath);

      log.i("file $fileName is found");
      return true;
    } catch (e) {
      log.e("file $fileName not found, error: $e");
      return false;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    const host =
        "https://efss.qloud.my/remote.php/dav/files/pinkbatman7777@gmail.com/";
    const email = "pinkbatman7777@gmail.com";
    const password = "mqwQ7gjTM@rL6Z9";

    client = webdavClient.newClient(
      host,
      user: email,
      password: password,
      debug: true,
    );

    // Set the public request headers
    client.setHeaders({'accept-charset': 'utf-8'});

    try {
      await client.ping();

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
      required String parentFolder}) async {
    fullFilePath = fullFilePath ?? "/$fileName";

    try {
      fullFilePath = fullFilePath ?? "/$fileName";

      if (fileContent != null) {
        log.i(
            "Uploading raw content for $fileName, dropboxPath = $fullFilePath");

        // Get the system's temporary directory
        final tempDir = Directory.systemTemp;

        // Create a temporary file in the system's temporary directory
        final tempFile = File('${tempDir.path}/temp.txt');

        // Write the string content to the temporary file
        await tempFile.writeAsString(fileContent, flush: true);

        await client.writeFromFile(tempFile.path, fullFilePath);

        log.i(
            "file $fileName successfully uploaded at dropboxPath $fullFilePath");

        // Delete the temporary file when done
        await tempFile.delete();

        return true;
      }

      return false;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
