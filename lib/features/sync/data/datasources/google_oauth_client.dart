import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_client_templdate.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleOAuthClient implements IOAuthClient {
  late GoogleSignIn googleSignIn;
  late drive.DriveApi driveApi;

  GoogleOAuthClient() {
    googleSignIn = GoogleSignIn.standard(scopes: []);
  }

  Future<bool> initialieClient() async {
    try {
      // check if credentials exist in local storage

      final googleUser = await googleSignIn.signIn();
      final headers = await googleUser?.authHeaders;
      if (headers == null) {
        return false;
      }

      final client = GoogleAuthHTTPClient(headers);
      driveApi = drive.DriveApi(client);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<File> downloadFile() {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<void> uploadFIle(File file) {
    // TODO: implement uploadFIle
    throw UnimplementedError();
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
