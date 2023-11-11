import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webdav_client/webdav_client.dart' as webdav_client;
import 'package:path/path.dart' as p;

final log = printer("NextCloudSyncClient");

class NextCloudSyncClient extends ISyncClient {
  late webdav_client.Client client;

  final UserConfigCubit userConfigCubit;

  NextCloudSyncClient({required this.userConfigCubit});

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
  Future<String> downloadFile(
    String fileName, {
    bool outputAsFile = false,
    String? fullFilePath,
  }) async {
    try {
      log.i(
          "Downloading file $fileName at $fullFilePath, outputAsFile = $outputAsFile");

      // if file path is not passed, we assume it is present in root folder
      fullFilePath = fullFilePath ?? "/$fileName";

      final binaryRes = await client.read(fullFilePath);
      log.i("Successfully download  file $fileName at $fullFilePath");

      if (!outputAsFile) {
        String result = utf8.decode(binaryRes);
        return result;
      }

      // save the file, and return the file's path
      final appDocDir = await getApplicationDocumentsDirectory();
      final copiedFile = File('${appDocDir.path}/${p.basename(fileName)}');
      copiedFile.writeAsBytes(binaryRes);

      return copiedFile.path.toString();
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<DateTime?> getNoteCreatedTime(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    log.i("Getting metadata for $fileName at $fullFilePath");

    try {
      fullFilePath = fullFilePath ?? "/$fileName";

      // Remove fileName from fullFilePath

      int lastSlashIndex = fullFilePath.lastIndexOf("/");
      if (lastSlashIndex != -1) {
        fullFilePath = fullFilePath.substring(0, lastSlashIndex);
      }

      var list = await client.readDir(fullFilePath);

      DateTime? createdAt;

      for (var f in list) {
        if (f.name == fileName) {
          createdAt = f.mTime;
        }
      }

      log.i("created at = $createdAt");

      return createdAt;
    } catch (e) {
      log.e(e);
      return null;
    }
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

    client = webdav_client.newClient(
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
      required String fullFilePath}) async {
    // update is same as write in NextCloud

    try {
      log.i("Updating file for $fileName, nextCloudPath = $fullFilePath");

      // Get the system's temporary directory
      final tempDir = Directory.systemTemp;

      // Create a temporary file in the system's temporary directory
      final tempFile = File('${tempDir.path}/temp.txt');

      // Write the string content to the temporary file
      await tempFile.writeAsString(fileContent, flush: true);

      await client.writeFromFile(tempFile.path, fullFilePath);

      log.i(
          "file $fileName successfully upated at nextCloudPath $fullFilePath");

      // Delete the temporary file when done
      await tempFile.delete();

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<void> updateLastSynced() async {
    log.i("Updating last sync time");
    try {
      userConfigCubit.setUserConfig(UserConfigConstants.lastNextCloudSync,
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> uploadFile(
      {String? fileContent,
      String? fileName,
      File? file,
      String? fullFilePath,
      required String parentFolder}) async {
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
      } else if (file != null) {
        log.i("uploading asset at $fullFilePath");

        await client.writeFromFile(file.path, fullFilePath);

        log.i("asset file successfully uploaded at dropboxPath $fullFilePath");
        return true;
      }

      return false;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
