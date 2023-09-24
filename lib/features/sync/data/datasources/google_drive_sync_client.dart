import 'dart:convert';
import 'dart:io';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final log = printer("GoogleDriveSyncClient");

class GoogleDriveSyncClient implements ISyncClient {
  late GoogleSignIn googleSignIn;
  late drive.DriveApi driveApi;

  final UserConfigCubit userConfigCubit;
  GoogleDriveSyncClient({required this.userConfigCubit}) {
    googleSignIn = GoogleSignIn.standard(scopes: [
      drive.DriveApi.driveAppdataScope,
    ]);
  }

  @override
  Future<bool> initialieClient() async {
    try {
      Map<String, String> headers;

      // try to login silently, it will be successful if we already have the permission
      GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      if (googleSignInAccount != null) {
        log.i("silent login successful");
        headers = await googleSignInAccount.authHeaders;
      } else {
        log.i("prompting new google sign in");

        googleSignInAccount = await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          log.i("prompted login successful");
          headers = await googleSignInAccount.authHeaders;
        } else {
          return false;
        }
      }

      userConfigCubit.setUserConfig(
          UserConfigConstants.googleDriveUserInfo, googleSignInAccount.email);

      final client = GoogleAuthHTTPClient(headers);
      driveApi = drive.DriveApi(client);
      log.i("drive api created successfully from live auth headers");

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> signIn() async {
    try {
      Map<String, String> headers;

      // try to login silently, it will be successful if we already have the permission
      GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      log.i("prompting new google sign in");

      googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        log.i("prompted login successful");
        headers = await googleSignInAccount.authHeaders;
      } else {
        return false;
      }

      userConfigCubit.setUserConfig(
          UserConfigConstants.googleDriveUserInfo, googleSignInAccount.email);

      final client = GoogleAuthHTTPClient(headers);
      driveApi = drive.DriveApi(client);
      log.i("drive api created successfully from live auth headers");

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> isFilePresent(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    final mimeType = folder ? "application/vnd.google-apps.folder" : null;

    try {
      log.i("Searching for $fileName file");

      // skipping mimeTypes for files as of now, as it is causing some issues
      final String searchQuery = mimeType != null
          ? "mimeType = '$mimeType' and name = '$fileName'"
          : "name = '$fileName'";

      const String fields = "files(id, name)";

      return _isFilePresent(searchQuery, fields);
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> createFolder(String folderName,
      {String? parentFolder, String? fullFolderPath}) async {
    try {
      String? parentFolderId;
      if (parentFolder != null) {
        parentFolderId = await _getFileIdIfPresent(parentFolder, folder: true);
        if (parentFolderId == null) {
          return false;
        }
      }

      log.i("Creating folder $folderName");
      const mimeType = "application/vnd.google-apps.folder";

      var folder = drive.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      folder.parents = [parentFolder ?? 'appDataFolder'];

      if (parentFolderId != null) {
        folder.parents = [parentFolderId];
      }

      await driveApi.files.create(
        folder,
      );
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String fileName,
      {bool folder = false, String? fullFilePath}) async {
    log.i("deleting file $fileName");

    try {
      String? fileId = await _getFileIdIfPresent(fileName, folder: folder);
      if (fileId == null) {
        return true;
      }
      await driveApi.files.delete(fileId);
      log.i("$fileName deleted successfully");

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> uploadFile({
    String? fileContent,
    String? fileName,
    File? file,
    String? fullFilePath,
    required String parentFolder,
  }) async {
    try {
      String? parentFolderId =
          await _getFileIdIfPresent(parentFolder, folder: true);

      if (parentFolderId == null) {
        log.e("aborting upload file");
        return false;
      }

      if (fileContent != null) {
        // convert file content to stream
        List<int> byteList = utf8.encode(fileContent);
        final Stream<List<int>> mediaStream =
            Future.value(byteList).asStream().asBroadcastStream();
        var media = drive.Media(mediaStream, byteList.length);

        // set file meta data
        var driveFile = drive.File();
        driveFile.name = "$fileName";
        driveFile.modifiedTime = DateTime.now().toUtc();
        driveFile.parents = [parentFolderId];
        // driveFile.mimeType = "application/vnd.google-apps.file";

        final response =
            await driveApi.files.create(driveFile, uploadMedia: media);

        log.i("file $fileName uploaded successfully $response");
      } else if (file != null) {
        // set file attributes from Flutter File objects
        var driveFile = drive.File();
        driveFile.parents = [parentFolderId];
        driveFile.name = p.basename(file.absolute.path);
        // driveFile.mimeType = "application/vnd.google-apps.file";

        var response = await driveApi.files.create(
          driveFile,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
        log.i("file $fileName created successfully $response");
      }

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<String> downloadFile(String fileName,
      {bool outputAsFile = false}) async {
    log.i(
        "Downloading file $fileName returning  ${outputAsFile ? "file content" : "file path"}");
    var fileId = await _getFileIdIfPresent(fileName);
    drive.Media file = await driveApi.files.get(fileId!,
        downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

    log.i("DOwnload successful");

    // return the content as string
    if (!outputAsFile) {
      String result = await utf8.decodeStream(file.stream);
      return result;
    }

    List<int> dataStore = [];
    await for (var data in file.stream) {
      dataStore.insertAll(dataStore.length, data);
    }
    // save the file, and return the file's path
    final appDocDir = await getApplicationDocumentsDirectory();

    final copiedFile = File('${appDocDir.path}/${p.basename(fileName)}');
    copiedFile.writeAsBytes(dataStore);
    return copiedFile.path.toString();
  }

  @override
  Future<bool> updateFile(
      {required String fileName, required String fileContent}) async {
    log.i("updating file $fileName");
    try {
      String? fileId = await _getFileIdIfPresent(fileName);
      if (fileId == null) {
        return false;
      }

      List<int> byteList = utf8.encode(fileContent);
      final Stream<List<int>> mediaStream =
          Future.value(byteList).asStream().asBroadcastStream();
      var media = drive.Media(mediaStream, byteList.length);

      var driveFile = drive.File();
      driveFile.name = fileName;

      await driveApi.files.update(driveFile, fileId, uploadMedia: media);
      log.i("$fileName updated successfully");

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    userConfigCubit.setUserConfig(
        UserConfigConstants.googleDriveUserInfo, null);
    log.i("sign out successful");
  }

  @override
  Future<String?> getSignedInUserInfo() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      return googleSignInAccount?.email;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      return googleSignInAccount != null;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<void> updateLastSynced() async {
    log.i("Updating last sync time");
    try {
      userConfigCubit.setUserConfig(UserConfigConstants.lastGoogleDriveSync,
          DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<DateTime?> getNoteCreatedTime(String fileName,
      {bool folder = false}) async {
    log.i("Searching for createdTime of $fileName");

    final mimeType = folder ? "application/vnd.google-apps.folder" : null;

    final String searchQuery = mimeType != null
        ? "mimeType = '$mimeType' and name = '$fileName'"
        : "name = '$fileName'";

    const String fields = "files(id, name, createdTime)";

    final found = await driveApi.files
        .list(q: searchQuery, $fields: fields, spaces: 'appDataFolder');

    final files = found.files;

    if (files == null || files.isEmpty) {
      log.i("File $fileName not found");
      return null;
    }

    return files.first.createdTime;
  }

  //* Private util methods

  Future<bool> _isFilePresent(String searchQuery, String fields) async {
    final found = await driveApi.files
        .list(q: searchQuery, $fields: fields, spaces: 'appDataFolder');

    final files = found.files;

    if (files == null || files.isEmpty) {
      log.i("File not found");
      return false;
    }

    log.i("File found");
    return true;
  }

  Future<String?> _getFileIdIfPresent(String fileName,
      {bool folder = false}) async {
    final mimeType = folder ? "application/vnd.google-apps.folder" : null;

    final String searchQuery = mimeType != null
        ? "mimeType = '$mimeType' and name = '$fileName'"
        : "name = '$fileName'";

    const String fields = "files(id, name)";

    final found = await driveApi.files
        .list(q: searchQuery, $fields: fields, spaces: 'appDataFolder');

    final files = found.files;

    if (files == null || files.isEmpty) {
      log.i("File $fileName not found");
      return null;
    }

    log.i(
        "$fileName found file id = ${files.first.id}, number of files = ${files.length}");
    return files.first.id;
  }
}

class GoogleAuthHTTPClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthHTTPClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
