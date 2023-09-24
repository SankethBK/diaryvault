# dropbox client

[![pub package](https://img.shields.io/pub/v/dropbox_client.svg)](https://pub.dartlang.org/packages/dropbox_client)

A flutter plugin for accessing Dropbox.

## Setup

Register a Dropbox API app from https://www.dropbox.com/developers .
You need dropbox key and dropbox secret.

For Android, add below in AndroidManifest.xml (replace DROPBOXKEY with your key)

        <activity
            android:name="com.dropbox.core.android.AuthActivity"
            android:configChanges="orientation|keyboard"
            android:launchMode="singleTask">
            <intent-filter>

                <!-- Change this to be db- followed by your app key -->
                <data android:scheme="db-DROPBOXKEY" />

                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.BROWSABLE" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </activity>

If you need more help setting up Android, please read https://github.com/dropbox/dropbox-sdk-java#setup .


For iOS, 
1) add below in Info.plist

        <key>LSApplicationQueriesSchemes</key>
          <array>
              <string>dbapi-8-emm</string>
              <string>dbapi-2</string>
          </array>

2) add below in Info.plist (replace DROPBOXKEY with your key)

        <key>CFBundleURLTypes</key>
          <array>
            <dict>
              <key>CFBundleURLSchemes</key>
              <array>
                <string>db-DROPBOXKEY</string>
              </array>
              <key>CFBundleURLName</key>
              <string></string>
            </dict>
          </array>
          
3.a) If you are using Swift, add below code to AppDelegate.swift

        import ObjectiveDropboxOfficial

        // should be inside AppDelegate class
        override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          if let authResult = DBClientsManager.handleRedirectURL(url) {
              if authResult.isSuccess() {
                  print("dropbox auth success")
              } else if (authResult.isCancel()) {
                  print("dropbox auth cancel")
              } else if (authResult.isError()) {
                  print("dropbox auth error \(authResult.errorDescription)")
              }
          }
          return true
        }

        // if your are linked with ObjectiveDropboxOfficial 6.x use below code instead

        override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          DBClientsManager.handleRedirectURL(url, completion:{ (authResult) in
            if let authResult = authResult {
                if authResult.isSuccess() {
                    print("dropbox auth success")
                } else if (authResult.isCancel()) {
                    print("dropbox auth cancel")
                } else if (authResult.isError()) {
                    print("dropbox auth error \(authResult.errorDescription)")
                }
            }
          });
          return true
        }

3.b) If you are using Objective C, add below code to AppDelegate.m

        #import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

        - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
          DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
          if (authResult != nil) {
            if ([authResult isSuccess]) {
              NSLog(@"Success! User is logged into Dropbox.");
            } else if ([authResult isCancel]) {
              NSLog(@"Authorization flow was manually canceled by user!");
            } else if ([authResult isError]) {
              NSLog(@"Error: %@", authResult);
            }
          }
          return NO;          
        }

        // if your are linked with ObjectiveDropboxOfficial 6.x use below code instead

        - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
          BOOL result = [DBClientsManager handleRedirectURL:url completion: ^(DBOAuthResult *authResult) {
            if (authResult != nil) {
              if ([authResult isSuccess]) {
                NSLog(@"Success! User is logged into Dropbox.");
              } else if ([authResult isCancel]) {
                NSLog(@"Authorization flow was manually canceled by user!");
              } else if ([authResult isError]) {
                NSLog(@"Error: %@", authResult);
              }
            }
          }];
          return NO;          
        }

4) Update Deployment Target to iOS 9.0 or above from Xcode. (dropbox_client 0.7.0 and above)
        
If you need more help setting up for iOS, please read https://github.com/dropbox/dropbox-sdk-obj-c#get-started .


## Usage

```
import 'package:dropbox_client/dropbox_client.dart';

Future initDropbox() async {
    // init dropbox client. (call only once!)
    await Dropbox.init(dropbox_clientId, dropbox_key, dropbox_secret);
}
```

```
// Legacy Authorization
String accessToken;

Future testLogin() async {
  // this will run Dropbox app if possible, if not it will run authorization using a web browser.
  await Dropbox.authorize();
}

Future getAccessToken() async {
  accessToken = await Dropbox.getAccessToken();
}

Future loginWithAccessToken() async {
  await Dropbox.authorizeWithAccessToken(accessToken);
}

Future testLogout() async {
  // unlink removes authorization
  await Dropbox.unlink();
}
```

```
// OAuth 2 code flow with PKCE that grants a short-lived token
String credentials;

Future testLogin() async {
  // this will run Dropbox app if possible, if not it will run authorization using a web browser.
  await Dropbox.authorizePKCE();
}

Future getCredentials() async {
  credentials = await Dropbox.getCredentials();
}

Future loginWithCredentials() async {
  await Dropbox.authorizeWithCredentials(credentials);
}

Future testLogout() async {
  // unlink removes authorization
  await Dropbox.unlink();
}
```

```
// List / Upload / Download

Future testListFolder() async {
  final result = await Dropbox.listFolder(''); // list root folder
  print(result);
  
  final url = await Dropbox.getTemporaryLink('/file.txt');
  print(url);
}

Future testUpload() async {
  final filepath = '/path/to/local/file.txt';
  final result = await Dropbox.upload(filepath, '/file.txt', (uploaded, total) {
    print('progress $uploaded / $total');
  });
}

Future testDownload() async {
  final filepath = '/path/to/local/file.txt';
  final result = await Dropbox.download('/dropbox_file.txt', filepath, (downloaded, total) {
    print('progress $downloaded / $total');
  });
}
```

Example can be found in example folder.
