import 'dart:convert';
import 'dart:io';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_client_templdate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'temeplates/oauth_key_data_source_template.dart';

final log = printer("GoogleOAuthClient");

class GoogleOAuthClient implements IOAuthClient {
  final IOAuthKeyDataSource oAuthKeyDataSource;

  late GoogleSignIn googleSignIn;
  late drive.DriveApi driveApi;

  final key = "google.auth";

  GoogleOAuthClient({required this.oAuthKeyDataSource}) {
    googleSignIn = GoogleSignIn.standard(scopes: [
      drive.DriveApi.driveFileScope,
    ]);
  }

  @override
  Future<bool> initialieClient() async {
    try {
      // check if credentials exist in local storage
      final value = await oAuthKeyDataSource.getOAuthKey(key);
      // if (value != null) {
      //   log.i("auth headers retrieved from local storage $value");

      //   final client =
      //       GoogleAuthHTTPClient(Map<String, String>.from(jsonDecode(value)));
      //   driveApi = drive.DriveApi(client);

      //   log.i("drive api created successfully from local auth headers");
      //   return true;
      // }

      log.i("local headers not found, making a new signin call");

      final googleUser = await googleSignIn.signIn();
      final headers = await googleUser?.authHeaders;
      if (headers == null) {
        log.w("user cancelled the sign in");
        return false;
      }

      log.i("headers retrieved from sign in $headers");

      final client = GoogleAuthHTTPClient(headers);
      driveApi = drive.DriveApi(client);
      log.i("drive api created successfully from live auth headers");

      // store the headers for next session
      oAuthKeyDataSource.setOAuthKey(key, jsonEncode(headers));

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> isFilePresent(String fileName, {bool folder = false}) async {
    final mimeType = folder
        ? "application/vnd.google-apps.folder"
        : "application/vnd.google-apps.file";

    try {
      log.i("Searching for $fileName file");

      final String searchQuery =
          "mimeType = '$mimeType' and name = '$fileName'";
      const String fields = "files(id, name)";

      return _isFilePresent(searchQuery, fields);
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> createFolder(String folderName, {String? parentFolder}) async {
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

      if (parentFolderId != null) {
        folder.parents = [parentFolderId];
      }

      await driveApi.files.create(folder);
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteFile(String fileName, {bool folder = false}) async {
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
    String? fileExtension,
    File? file,
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
        // convert file conetent to stream
        final Stream<List<int>> mediaStream =
            Future.value(fileContent.codeUnits).asStream().asBroadcastStream();
        var media = drive.Media(mediaStream, fileContent.length);

        // set file meta data
        var driveFile = drive.File();
        driveFile.name = "$fileName.$fileExtension";
        driveFile.modifiedTime = DateTime.now().toUtc();
        driveFile.parents = [parentFolderId];

        final response =
            await driveApi.files.create(driveFile, uploadMedia: media);

        log.i("file $fileName uploaded successfully $response");
      } else if (file != null) {
        // set file attributes from Flutter File objects
        var driveFile = drive.File();
        driveFile.parents = [parentFolderId];
        driveFile.name = p.basename(file.absolute.path);
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
  Future<File> downloadFile() {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  //* Private util methods

  Future<bool> _isFilePresent(String searchQuery, String fields) async {
    final found = await driveApi.files.list(
      q: searchQuery,
      $fields: fields,
    );

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
    final mimeType = folder
        ? "application/vnd.google-apps.folder"
        : "application/vnd.google-apps.file";

    final String searchQuery = "mimeType = '$mimeType' and name = '$fileName'";
    const String fields = "files(id, name)";

    final found = await driveApi.files.list(
      q: searchQuery,
      $fields: fields,
    );

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
