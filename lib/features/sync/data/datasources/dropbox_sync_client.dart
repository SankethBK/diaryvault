import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stateless_dropbox_client/stateless_dropbox_client.dart';

final log = printer("DropboxSyncClient");

class DropboxSyncClient implements ISyncClient {
  final UserConfigCubit userConfigCubit;

  static const REFRESH_TOKEN = "DROPBOX_REFRESH_TOKEN";
  static const DROPBOX_SECRET = "DROPBOX_SECRET";

  final String dropboxClientId = 'diaryvault';
  final String dropboxKey = 'jgrid9k326jh3ge';
  String? dropboxSecret;
  late FlutterSecureStorage secureStorage;

  String? accessToken;
  String? refreshToken;

  DropboxSyncClient({required this.userConfigCubit}) {
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  @override
  Future<void> signIn() async {
    log.i("Starting signIn");

    final isSignedIn = await this.isSignedIn();

    if (!isSignedIn) {
      log.i("Attempting new login ");

      // Present the dialog to the user
      final result = await Dropbox.authenticate();

      final code = Uri.parse(result).queryParameters['code'];

      final res = await Dropbox.exchangeAuthorizationCodeForAccessToken(
          dropboxKey, dropboxSecret!, code!);

      accessToken = res["access_token"];
      refreshToken = res["refresh_token"];

      log.i("Signin successful");

      // store refresh token for future use
      await secureStorage.write(key: REFRESH_TOKEN, value: refreshToken);

      // get account into
      await getSignedInUserInfo();
    }
  }

  @override
  Future<bool> createFolder(String folderName,
      {String? parentFolder, String? fullFolderPath}) async {
    log.i("creating folder $folderName in $fullFolderPath");

    try {
      // if file path is not passed, we assume it is present in root folder
      fullFolderPath = fullFolderPath ?? "/$folderName";
      final res = await Dropbox.createFolder(fullFolderPath, accessToken!);

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

      final res = await Dropbox.deleteFile(fullFilePath, accessToken!);
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

      final binaryRes = await Dropbox.download(fullFilePath, accessToken!);
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
  Future<DateTime?> getNoteCreatedTime(
    String fileName, {
    bool folder = false,
    String? fullFilePath,
  }) async {
    try {
      log.i("Getting metadata for $fileName at $fullFilePath");

      // if file path is not passed, we assume it is present in root folder
      fullFilePath = fullFilePath ?? "/$fileName";

      final res = await Dropbox.getMetaData(fullFilePath, accessToken!);
      log.i("metadata for file $fileName found $res");

      Map<String, dynamic> resMap = json.decode(res);

      final createdDateTimeString = resMap["server_modified"];

      if (createdDateTimeString != null) {
        DateTime createdDateTime = DateTime.parse(createdDateTimeString);
        return createdDateTime;
      }

      return null;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  @override
  Future<String?> getSignedInUserInfo() async {
    if (accessToken == null) {
      await signIn();
    }

    final accountInfo = await Dropbox.getCurrentAccount(accessToken!);
    log.i("account info = $accountInfo");

    // first preference would be email, if it doesn't exists username would be used
    final dropboxUserInfo = accountInfo["email"] ?? accountInfo["display_name"];

    userConfigCubit.setUserConfig(
        UserConfigConstants.dropBoxUserInfo, dropboxUserInfo);

    return dropboxUserInfo;
  }

  @override
  Future<bool> initialieClient() async {
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

      final res = await Dropbox.getMetaData(fullFilePath, accessToken!);
      log.i("file $fileName found $res");
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  Future<void> fetchDropboxSecret() async {
    log.i("fetching dropbox client token");

    final Uri url = Uri.parse(utf8.decode(base64.decode(
        "aHR0cHM6Ly9kOTNuZGpzMjMubmV0bGlmeS5hcHAvLm5ldGxpZnkvZnVuY3Rpb25zL2FwaS9nZXQtZHJvcGJveC10b2tlbg==")));

    final Map<String, String> headers = {
      'X-Package-Name': 'me.sankethbk.dairyapp',
    };

    final response = await http.get(url, headers: headers);
    log.i("dropbox fetch token response = ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('dropbox_token')) {
        dropboxSecret = data['dropbox_token'].toString();
        await secureStorage.write(key: DROPBOX_SECRET, value: dropboxSecret);
      } else {
        throw Exception("Dropbox login failed");
      }
    } else {
      throw Exception("Dropbox login failed");
    }
  }

  @override
  Future<bool> isSignedIn() async {
    log.i("Checking for existing session");

    if (dropboxSecret == null) {
      // check for dropbox secret locallu
      final _dropboxSecret = await secureStorage.read(key: DROPBOX_SECRET);

      if (_dropboxSecret == null) {
        log.i("dropbox secret not found locally");
        await fetchDropboxSecret();
      } else {
        log.i("dropbox client token found locally");
        dropboxSecret = _dropboxSecret;
      }
    }

    // if dropBoxUserInfo is empty, force another signin even though there is existign session
    final dropBoxUserInfo =
        userConfigCubit.state.userConfigModel?.dropBoxUserInfo;

    if (dropBoxUserInfo == null) {
      return false;
    }

    final _refreshToken = await secureStorage.read(key: REFRESH_TOKEN);
    if (_refreshToken != null) {
      log.i("Existing refresh token found");

      // get new access token using the refresh token to check if its valid
      final newAccessToken = await Dropbox.getNewAccessToken(
          dropboxKey, dropboxSecret!, _refreshToken);

      accessToken = newAccessToken;
      log.i("retrieved new access token");
      return true;
    }

    log.i("Existing session not found");

    return false;
  }

  @override
  Future<void> signOut() async {
    // clear out the access token and delete it
    accessToken = null;
    await secureStorage.delete(key: REFRESH_TOKEN);

    await userConfigCubit.setUserConfig(
        UserConfigConstants.dropBoxUserInfo, null);

    log.i("sign out successful");
  }

  @override
  Future<bool> updateFile({
    required String fileName,
    required String fileContent,
    required String fullFilePath,
  }) async {
    log.i("Updating file $fileName at $fullFilePath");
    try {
      // Encode the string content as bytes
      List<int> contentBytes = utf8.encode(fileContent);

      final res =
          await Dropbox.updateFile(contentBytes, fullFilePath, accessToken!);
      log.i("updated file $fileName at $fullFilePath, $res");
      return res;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<void> updateLastSynced() async {
    log.i("Updating last sync time");
    try {
      userConfigCubit.setUserConfig(UserConfigConstants.lastDropboxSync,
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

        final res =
            await Dropbox.upload(tempFile.path, fullFilePath, accessToken!);

        log.i(
            "file $fileName successfully uploaded at dropboxPath $fullFilePath, res = $res");

        // Delete the temporary file when done
        await tempFile.delete();

        return true;
      } else if (file != null) {
        log.i("uploading asset at $fullFilePath");

        final res = await Dropbox.upload(file.path, fullFilePath, accessToken!);

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
