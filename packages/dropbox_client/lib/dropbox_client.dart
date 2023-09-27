import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dropbox_client/account_info.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

typedef DropboxProgressCallback = void Function(
    int currentBytes, int totalBytes);

class _CallbackInfo {
  int filesize;
  DropboxProgressCallback? callback;

  _CallbackInfo(this.filesize, this.callback);
}

class Dropbox {
  static const MethodChannel _channel = const MethodChannel('dropbox');

  static int _callbackInt = 0;
  static Map<int, _CallbackInfo> _callbackMap = <int, _CallbackInfo>{};

  /// Initialize dropbox library
  ///
  /// init() should be called only once.
  static Future<bool> init(String clientId, String key, String secret) async {
    _channel.setMethodCallHandler(_handleMethodCall);

    return await _channel.invokeMethod(
            'init', {'clientId': clientId, 'key': key, 'secret': secret}) ??
        false;
  }

  static Future<void> _handleMethodCall(MethodCall call) async {
    // print('_handleMethodCall: ' + call.method);
    // print(call.arguments);
    var args = call.arguments as List;
    var key = args[0];
    var bytes = args[1];

    if (_callbackMap.containsKey(key)) {
      final info = _callbackMap[key]!;
      if (info.callback != null) {
        if (info.filesize == 0 && args.length > 2) {
          info.filesize = args[2];
        }
        info.callback!(bytes, info.filesize);
      }
    }
  }

  /// Authorize using Dropbox app or web browser.
  ///
  /// Authorize using Dropbox app if it's installed. If not installed, it calls external web browser for authorization.
  /// When user authorizes, no feedback is available. call getAccessToken() to check if authorized.
  static Future<void> authorize() async {
    await _channel.invokeMethod('authorize');
  }

  /// Authorize using short-lived tokens
  static Future<void> authorizePKCE() async {
    await _channel.invokeMethod('authorizePKCE');
  }

  /// Unlink account (remove authorization).
  static Future<void> unlink() async {
    await _channel.invokeMethod('unlink');
  }

  /// Authorize with AccessToken
  ///
  /// use getAccessToken() to get Access Token after successful authorize().
  /// authorizeWithAccessToken() will authorize without user interaction if access token is valid.
  static Future<void> authorizeWithAccessToken(String accessToken) async {
    await _channel
        .invokeMethod('authorizeWithAccessToken', {'accessToken': accessToken});
  }

  /// Authorize with Credentials
  ///
  /// use getCredentials() to get Access and Refresh Token after successful authorizePKCE().
  /// authorizeWithCredentials() will authorize without user interaction if access and refresh tokens are valid.
  /// It should automatically refresh the access token if expired
  static Future<void> authorizeWithCredentials(String credentials) async {
    await _channel
        .invokeMethod('authorizeWithCredentials', {'credentials': credentials});
  }

  // static Future<String> getAuthorizeUrl() async {
  //   return await _channel.invokeMethod('getAuthorizeUrl');
  // }

  // static Future<String> finishAuth(String code) async {
  //   return await _channel.invokeMethod('finishAuth', {'code': code});
  // }

  /// get Access Token after authorization.
  ///
  /// returns null if not authorized.
  static Future<String?> getAccessToken() async {
    return await _channel.invokeMethod('getAccessToken');
  }

  /// same for PKCE
  ///
  static Future<String?> getCredentials() async {
    return await _channel.invokeMethod('getCredentials');
  }

  /// get account name
  ///
  /// return null if not authorized.
  static Future<String?> getAccountName() async {
    return await _channel.invokeMethod('getAccountName');
  }

  /// get folder/file list for path.
  ///
  /// returns List<dynamic>. Use path='' for accessing root folder. List items are not sorted.
  static Future listFolder(String path) async {
    return await _channel.invokeMethod('listFolder', {'path': path});
  }

  /// get temporary link url for file
  ///
  /// returns url for accessing dropbox file.
  static Future<String?> getTemporaryLink(String path) async {
    return await _channel.invokeMethod('getTemporaryLink', {'path': path});
  }

  /// get base64 string of thumbnail for image file
  ///
  /// returns base64 string of thumbnail for dropbox image file.
  static Future<String?> getThumbnailBase64String(String path) async {
    return await _channel
        .invokeMethod('getThumbnailBase64String', {'path': path});
  }

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
    print("code = $authorizationCode");
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$key:$secret'));

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

  /// download file from dropboxpath to local file(filepath).
  ///
  /// filepath is local file path. dropboxpath should start with /.
  /// callback for monitoring progress : (downloadedBytes, totalExpectedBytes) { } (can be null)
  // static Future download(String dropboxpath,
  //     [DropboxProgressCallback? callback]) async {
  //   final key = ++_callbackInt;

  //   _callbackMap[key] = _CallbackInfo(0, callback);

  //   final ret = await _channel
  //       .invokeMethod('download', {'dropboxpath': dropboxpath, 'key': key});

  //   _callbackMap.remove(key);

  //   return ret;
  // }

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
}
