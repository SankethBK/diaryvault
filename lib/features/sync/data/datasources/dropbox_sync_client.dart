import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

final log = printer("DropboxSyncClient");

class DropboxSyncClient implements ISyncClient {
  final UserConfigCubit userConfigCubit;

  final String dropboxClientId = 'diaryvault';
  final String dropboxKey = 'rqndas0qvioj4f1';
  final String dropboxSecret = dotenv.env['DROPBOX_SECET'] ?? "no_secret";

  String? accessToken;

  DropboxSyncClient({required this.userConfigCubit});

  @override
  Future<void> signIn() async {
    log.i("dropboxSecret: $dropboxSecret");

    final res = await Dropbox.init(dropboxClientId, dropboxKey, dropboxSecret);
    log.i("Starting signIn:= $res");

    final isSignedIn = await this.isSignedIn();

    log.i("isSignedIn:= $isSignedIn");

    if (!isSignedIn) {
      log.i("Attempting new login ");
      await Dropbox.authorize();
    }
  }

  @override
  Future<bool> createFolder(String folderName,
      {String? parentFolder, String? fullFolderPath}) async {
    log.i("creating folder $folderName in $fullFolderPath");

    try {
      // if file path is not passed, we assume it is present in root folder
      fullFolderPath = fullFolderPath ?? "/$folderName";
      final res = await Dropbox.createFolder(fullFolderPath);

      log.i("created folder for $folderName at $fullFolderPath, $res");

      return res;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    log.i("Attempting to delete $fileName at $fullFilePath");
    try {
      // if file path is not passed, we assume it is present in root folder
      fullFilePath = fullFilePath ?? "/$fileName";

      final res = await Dropbox.deleteFile(fullFilePath);
      log.i("Deleted $fileName at $fullFilePath, $res");

      return res;
    } catch (e) {
      log.e(e);
      return false;
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

      final binaryRes = await Dropbox.download(fullFilePath);
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
  Future<DateTime?> getNoteCreatedTime(String fileName) {
    // TODO: implement getNoteCreatedTime
    throw UnimplementedError();
  }

  @override
  Future<String?> getSignedInUserInfo() async {
    final accountInfo = await Dropbox.getCurrentAccount();
    log.i("accountInfo:= ${accountInfo?.email}");

    // first preference would be email, if it doesn't exists username would be used
    final dropboxUserInfo =
        accountInfo?.email ?? accountInfo?.name!.displayName;

    userConfigCubit.setUserConfig(
        UserConfigConstants.dropBoxUserInfo, dropboxUserInfo);

    return dropboxUserInfo;
  }

  @override
  Future<bool> initialieClient() async {
    // TODO: implement this properly based on accesstoken
    await signIn();
    return true;
  }

  @override
  Future<bool> isFilePresent(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    try {
      log.i("Searching for $fileName file");

      // if file path is not passed, we assume it is present in root folder
      fullFilePath = fullFilePath ?? "/$fileName";

      final res = await Dropbox.getMetaData(fullFilePath);
      log.i("file $fileName found $res");
      return res;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    log.i("Checking for existing session");

    final _accessToken = await Dropbox.getAccessToken();
    if (_accessToken != null) {
      log.i("Existing access token found");

      if (accessToken == null || accessToken!.isEmpty) {
        accessToken = _accessToken;
      }
      return true;
    }

    log.i("Existing session not found");

    return false;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<bool> updateFile(
      {required String fileName, required String fileContent}) {
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

        final res = await Dropbox.upload(tempFile.path, fullFilePath);

        log.i(
            "file $fileName successfully uploaded at dropboxPath $fullFilePath, res = $res");

        // Delete the temporary file when done
        await tempFile.delete();

        return true;
      } else if (file != null) {
        log.i("uploading asset at $fullFilePath");

        final res = await Dropbox.upload(file.path, fullFilePath);

        log.i(
            "asset file successfully uploaded at dropboxPath $fullFilePath, res = $res");
      }
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
