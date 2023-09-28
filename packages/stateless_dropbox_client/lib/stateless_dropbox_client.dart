library stateless_dropbox_client;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

/// A Calculator.
class Dropbox {
  /// upload local file in filepath to dropboxpath.
  ///
  /// filepath is local file path. dropboxpath should start with /.
  /// callback for monitoring progress : (uploadedBytes, totalBytes) { } (can be null)
  static Future upload(
    String filePath,
    String dropboxpath,
    String accessToken,
  ) async {
    // Read the file into bytes
    final fileBytes = File(filePath).readAsBytesSync();

    // Prepare the request headers
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Dropbox-API-Arg': jsonEncode({
        'autorename': false,
        'mode': 'add',
        'mute': false,
        'path': dropboxpath,
        'strict_conflict': false,
      }),
      'Content-Type': 'application/octet-stream',
    };

    // Send the POST request to Dropbox
    final response = await http.post(
      Uri.parse('https://content.dropboxapi.com/2/files/upload'),
      headers: headers,
      body: fileBytes,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  static Future<String> authenticate() async {
    final response = await FlutterWebAuth2.authenticate(
      url:
          "https://www.dropbox.com/oauth2/authorize?client_id=rqndas0qvioj4f1&response_type=code&token_access_type=offline&redirect_uri=https://sankethbk.netlify.app/oauth2redirect",
      callbackUrlScheme: "db-rqndas0qvioj4f1",
      preferEphemeral: true,
    );

    return response;
  }

  static Future<bool> updateFile(
      List<int> binaryContent, String dropboxpath, String accessToken) async {
    var url = Uri.parse('https://content.dropboxapi.com/2/files/upload');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/octet-stream',
        'Dropbox-API-Arg': json.encode({
          'path': dropboxpath,
          'mode': {'.tag': 'overwrite'}
        })
      },
      body: binaryContent,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> exchangeAuthorizationCodeForAccessToken(
    String key,
    String secret,
    String authorizationCode,
  ) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$key:$secret'))}';

    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': basicAuth,
    };

    final Map<String, String> body = {
      'code': authorizationCode,
      'grant_type': 'authorization_code',
      'redirect_uri': 'https://sankethbk.netlify.app/oauth2redirect'
    };

    final Uri uri = Uri.parse('https://api.dropbox.com/oauth2/token');

    final http.Response response =
        await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to exchange authorization code for access token ${response.body}');
    }
  }

  // get new accessToken using refresh token
  static Future<String> getNewAccessToken(
      String key, String secret, String refreshToken) async {
    try {
      // Encode the key and secret as a Base64 string
      final base64authorization = base64Encode(utf8.encode('$key:$secret'));

      // Define the request headers and data
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic $base64authorization',
      };
      final body = {
        'refresh_token': refreshToken,
        'grant_type': 'refresh_token',
      };

      // Send the POST request to the Dropbox token endpoint
      final response = await http.post(
        Uri.parse('https://api.dropbox.com/oauth2/token'),
        headers: headers,
        body: body,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data["access_token"];
      } else {
        // Handle the error, e.g., by throwing an exception or returning an error message
        throw Exception('Failed to refresh access token');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      throw Exception('Error: $e');
    }
  }

  static Future<Uint8List> download(
      String dropboxpath, String accessToken) async {
    var url = Uri.parse('https://content.dropboxapi.com/2/files/download');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/octet-stream',
        'Dropbox-API-Arg': json.encode({"path": dropboxpath})
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.bodyBytes;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  /// get current account information.
  ///
  /// if no user is logged in, this method returns null,
  /// else it returns an AccountInfo object.
  static Future<Map<String, dynamic>> getCurrentAccount(
      String accessToken) async {
    var url =
        Uri.parse('https://api.dropboxapi.com/2/users/get_current_account');
    var response =
        await http.post(url, headers: {'Authorization': 'Bearer $accessToken'});
    return jsonDecode(response.body);
  }

  static Future<bool> createFolder(
      String fullFolderPath, String accessToken) async {
    var url = Uri.parse('https://api.dropboxapi.com/2/files/create_folder_v2');

    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
        body: json.encode({"path": fullFolderPath}));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  static Future<String> getMetaData(
      String fullFilePath, String accessToken) async {
    var url = Uri.parse('https://api.dropboxapi.com/2/files/get_metadata');

    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
        body: json.encode({"path": fullFilePath}));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  static Future<bool> deleteFile(
      String fullFilePath, String accessToken) async {
    var url = Uri.parse('https://api.dropboxapi.com/2/files/delete_v2');

    final response = await http.post(url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
        body: json.encode({"path": fullFilePath}));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else if (response.statusCode == 409) {
      // 409 means there is nothing to delete, so return true
      return true;
    } else {
      throw Exception(
          'Request failed with status code: ${response.statusCode}, message: ${response.body}');
    }
  }

  static Future<void> revokeDropboxToken(String accessToken) async {
    final url = Uri.parse('https://api.dropboxapi.com/2/auth/token/revoke');
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers, body: 'null');
    } catch (e) {
      // ignore if failed as this is not critical
    }
  }
}
