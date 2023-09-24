#import "DropboxPlugin.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@interface DropboxPlugin () {
    NSString *appKey;
}
@end

FlutterMethodChannel* channel;

@implementation DropboxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  channel = [FlutterMethodChannel
      methodChannelWithName:@"dropbox"
            binaryMessenger:[registrar messenger]];
  DropboxPlugin* instance = [[DropboxPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

+ (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

- (NSString *)authURLwithAppKey:(NSString *)appKey {
  NSURLComponents *components = [[NSURLComponents alloc] init];
  components.scheme = @"https";
  components.host = @"www.dropbox.com";
  components.path = @"/oauth2/authorize";

  NSString *localeIdentifier = [[NSBundle mainBundle] preferredLocalizations].firstObject ?: @"en";

  components.queryItems = @[
    [NSURLQueryItem queryItemWithName:@"response_type" value:@"code"],
    [NSURLQueryItem queryItemWithName:@"client_id" value:appKey],
    [NSURLQueryItem queryItemWithName:@"disable_signup" value: @"true" ],
    [NSURLQueryItem queryItemWithName:@"locale" value:localeIdentifier],
  ];
  return [components.URL absoluteString];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"init" isEqualToString:call.method]) {
//        NSString *clientId = call.arguments[@"clientId"];
        NSString *key = call.arguments[@"key"];
//        NSString *secret = call.arguments[@"secret"];
        if ([DBOAuthManager sharedOAuthManager]) {
          NSLog(@"Already initialized with appKey %@", appKey);
          result([NSNumber numberWithBool:TRUE]);
          return;
        }
        appKey = key;

//#define DOWNLOAD_ERROR_WORKAROUND
#ifdef DOWNLOAD_ERROR_WORKAROUND
        DBTransportDefaultConfig *transportConfiguration = [[DBTransportDefaultConfig alloc] initWithAppKey:key forceForegroundSession:YES];
        // forceForegroundSession: fixes download error on some devices (https://github.com/dropbox/dropbox-sdk-obj-c/issues/258)
        [DBClientsManager setupWithTransportConfig: transportConfiguration];
#else
      [DBClientsManager setupWithAppKey: key];
#endif
      
      result([NSNumber numberWithBool:TRUE]);

  } else if ([@"authorize" isEqualToString:call.method]) {

      [DBClientsManager authorizeFromController:[UIApplication sharedApplication]
                                     controller:[[self class] topMostController]
                                        openURL:^(NSURL *url) {
                                          NSLog(@"url = %@" , [url absoluteString]);
                                          [[UIApplication sharedApplication] openURL:url];
                                        }];
      result([NSNumber numberWithBool:TRUE]);
      
  } else if ([@"getAuthorizeUrl" isEqualToString:call.method]) {

      result([self authURLwithAppKey:appKey]);
      
  } else if ([@"finishAuth" isEqualToString:call.method]) {
//      NSString *code = call.arguments[@"code"];

      DBUserClient *client = [DBClientsManager authorizedClient];
      NSDictionary<NSString *, DBUserClient *> *clients =[DBClientsManager authorizedClients];
      NSLog(@"clients = %@", clients);
      for (NSString *key in clients.allKeys) {
          NSLog(@"key = %@", key);
          if (client == clients[key]) {
              result(key);
              return;
          }
      }

      result(client.accessToken);

  } else if ([@"authorizeWithAccessToken" isEqualToString:call.method]) {
      NSString *accessToken = call.arguments[@"accessToken"];

      [DBClientsManager authorizeClientFromKeychain:accessToken];

      result(@(TRUE));
  } else if ([@"authorizePKCE" isEqualToString:call.method]) {
      DBScopeRequest *scopeRequest = [[DBScopeRequest alloc] initWithScopeType:DBScopeTypeUser
                                                                        scopes:@[]
                                                          includeGrantedScopes:NO];
      [DBClientsManager authorizeFromControllerV2:[UIApplication sharedApplication]
                                       controller:[[self class] topMostController]
                            loadingStatusDelegate:nil
                                          openURL:^(NSURL *url) { [[UIApplication sharedApplication] openURL:url]; }
                                     scopeRequest:scopeRequest];

      result(@(TRUE));
  } else if ([@"authorizeWithCredentials" isEqualToString:call.method]) {
      NSString *accessToken = call.arguments[@"credentials"];
      // XXX iOS seems to use accessToken for management of keys (even if short lived PKCE is used)
      
      [DBClientsManager authorizeClientFromKeychain:accessToken];

      result(@(TRUE));
  } else if ([@"getCredentials" isEqualToString:call.method]) {
      // XXX iOS seems to use accessToken for management of keys (even if short lived PKCE is used)
      DBUserClient *client = [DBClientsManager authorizedClient];
      result(client.accessToken);

  } else if ([@"getAccountName" isEqualToString:call.method]) {
      DBUserClient *client = [DBClientsManager authorizedClient];
      
      [[client.usersRoutes getCurrentAccount] setResponseBlock:^(DBUSERSFullAccount * _Nullable account, DBNilObject * _Nullable routeError, DBRequestError * _Nullable networkError) {
          result(account.name.displayName);
      }];

//      result(@"accountname");
  } else if ([@"listFolder" isEqualToString:call.method]) {
      NSString *path = call.arguments[@"path"];
      DBUserClient *client = [DBClientsManager authorizedClient];
      
      [[client.filesRoutes listFolder:path]
      setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderError *routeError, DBRequestError *networkError) {
       
      if (response) {
          NSArray<DBFILESMetadata *> *entries = response.entries;
          NSString *cursor = response.cursor;
          BOOL hasMore = [response.hasMore boolValue];
          
          NSMutableArray *arr = [self parseEntries: entries];

          if (hasMore) {
              [self listFolderContinue:cursor result:result array:arr];
          } else {
              NSLog(@"List folder complete.");
              result(arr);
          }
              
        } else {
          NSLog(@"%@\n%@\n", routeError, networkError);
            result(@[]);
        }
      }];

  } else if ([@"getAccessToken" isEqualToString:call.method]) {
      DBUserClient *client = [DBClientsManager authorizedClient];
      result(client.accessToken);
      
  } else if ([@"unlink" isEqualToString:call.method]) {
      [DBClientsManager unlinkAndResetClients];
      
  } else if ([@"getTemporaryLink" isEqualToString:call.method]) {
      DBUserClient *client = [DBClientsManager authorizedClient];
      NSString *path = call.arguments[@"path"];

      [[client.filesRoutes getTemporaryLink:path] setResponseBlock:^(DBFILESGetTemporaryLinkResult *linkResult, DBFILESGetTemporaryLinkError * linkErr, DBRequestError* dbError) {
          if (linkResult) {
//                    NSLog(@"result = %@", result);
              if (linkResult.link) {
                  result(linkResult.link);
              } else {
                  result(@"error");
              }
          } else {
              result([NSString stringWithFormat:@"error = %@", linkErr]);
              NSLog(@"linkErr = %@", linkErr);
              NSLog(@"dbError = %@", dbError);
          }
      }];
  } else if ([@"getThumbnailBase64String" isEqualToString:call.method]) {
      DBUserClient *client = [DBClientsManager authorizedClient];
      NSString *path = call.arguments[@"path"];
      
      NSArray<DBFILESThumbnailArg *> *entries = @[[[DBFILESThumbnailArg alloc] initWithPath:path]];
      [[client.filesRoutes getThumbnailBatch:entries]
          setResponseBlock:^(DBFILESGetThumbnailBatchResult *thumbnailResult, DBFILESGetThumbnailBatchError *routeError, DBRequestError *networkError) {
          if (thumbnailResult) {
              DBFILESGetThumbnailBatchResultEntry *entry = thumbnailResult.entries[0];
              if (entry.isSuccess) {
                  DBFILESGetThumbnailBatchResultData *data = entry.success;
                  result(data.thumbnail);
              } else {
                  result(@"error");
              }
          } else if (routeError) {
              result([NSString stringWithFormat:@"error = %@", routeError]);
              NSLog(@"routeError = %@", routeError);
          } else if (networkError) {
              result([NSString stringWithFormat:@"error = %@", networkError]);
              NSLog(@"networkError = %@", networkError);
          };
      }];
  } else if ([@"upload" isEqualToString:call.method]) {
      NSString *filepath = call.arguments[@"filepath"];
      NSString *dropboxpath = call.arguments[@"dropboxpath"];
      NSNumber *key = call.arguments[@"key"];
      DBUserClient *client = [DBClientsManager authorizedClient];
      DBFILESWriteMode *mode = [[DBFILESWriteMode alloc] initWithOverwrite];

      NSError* error = nil;
      NSData* fileData = [NSData dataWithContentsOfFile:filepath  options:0 error:&error];

  
      if ([client.filesRoutes respondsToSelector:@selector(uploadData: mode: autorename: clientModified: mute: propertyGroups:strictConflict:contentHash:inputData:)]) {
          SEL selector = @selector(uploadData: mode: autorename: clientModified: mute: propertyGroups:strictConflict:contentHash:inputData:);
          IMP imp = [client.filesRoutes methodForSelector:selector];
          DBUploadTask *(*func)(id, SEL, NSString *, DBFILESWriteMode *, NSNumber *, NSDate *, NSNumber *, NSArray<DBFILEPROPERTIESPropertyGroup *> *, NSNumber *, NSString *, NSData *) = (void *)imp;
          DBUploadTask *task = func(client.filesRoutes, selector, dropboxpath, mode, @(YES), nil, @(NO), nil, nil, nil, fileData);
//
//          DBUploadTask *task = [client.filesRoutes uploadData:dropboxpath mode:mode autorename:@(YES) clientModified:nil mute:@(NO) propertyGroups:nil strictConflict:nil contentHash:nil inputData: fileData];

          [[task setResponseBlock:^(DBFILESFileMetadata *dResult, DBFILESUploadError *routeError, DBRequestError *networkError) {
              if (dResult) {
                  NSLog(@"%@\n", dResult);
                  result(@(TRUE));
              } else {
                  NSLog(@"%@\n%@\n", routeError, networkError);
                  result(@(FALSE));
              }
          }] setProgressBlock:^(int64_t bytesUploaded, int64_t totalBytesUploaded, int64_t totalBytesExpectedToUploaded) {
              NSLog(@"\n%lld\n%lld\n%lld\n", bytesUploaded, totalBytesUploaded, totalBytesExpectedToUploaded);
              [channel invokeMethod:@"progress" arguments:@[key, @(totalBytesUploaded)]];
          }];
          
      } else if ([client.filesRoutes respondsToSelector:@selector(uploadData: mode: autorename: clientModified: mute: propertyGroups:strictConflict: inputData:)]) {
          
          SEL selector = @selector(uploadData: mode: autorename: clientModified: mute: propertyGroups:strictConflict:inputData:);
          IMP imp = [client.filesRoutes methodForSelector:selector];
          /*
           - (DBUploadTask *)uploadData:(NSString *)path
                                   mode:(DBFILESWriteMode *)mode
                             autorename:(NSNumber *)autorename
                         clientModified:(NSDate *)clientModified
                                   mute:(NSNumber *)mute
                         propertyGroups:(NSArray<DBFILEPROPERTIESPropertyGroup *> *)propertyGroups
                         strictConflict:(NSNumber *)strictConflict
                            //contentHash:(NSString *)contentHash
                              inputData:(NSData *)inputData {
           */
          DBUploadTask *(*func)(id, SEL, NSString *, DBFILESWriteMode *, NSNumber *, NSDate *, NSNumber *, NSArray<DBFILEPROPERTIESPropertyGroup *> *, NSNumber *, NSData *) = (void *)imp;
          DBUploadTask *task = func(client.filesRoutes, selector, dropboxpath, mode, @(YES), nil, @(NO), nil, nil, fileData);

          [[task setResponseBlock:^(DBFILESFileMetadata *dResult, DBFILESUploadError *routeError, DBRequestError *networkError) {
              if (dResult) {
                  NSLog(@"%@\n", dResult);
                  result(@(TRUE));
              } else {
                  NSLog(@"%@\n%@\n", routeError, networkError);
                  result(@(FALSE));
              }
          }] setProgressBlock:^(int64_t bytesUploaded, int64_t totalBytesUploaded, int64_t totalBytesExpectedToUploaded) {
              NSLog(@"\n%lld\n%lld\n%lld\n", bytesUploaded, totalBytesUploaded, totalBytesExpectedToUploaded);
              [channel invokeMethod:@"progress" arguments:@[key, @(totalBytesUploaded)]];
          }];
      }
      
  } else if ([@"download" isEqualToString:call.method]) {
      NSString *filepath = call.arguments[@"filepath"];
      NSString *dropboxpath = call.arguments[@"dropboxpath"];
      NSNumber *key = call.arguments[@"key"];
      NSURL *fileUrl = [NSURL fileURLWithPath:filepath isDirectory:NO];
      DBUserClient *client = [DBClientsManager authorizedClient];
      
//      NSLog(@"fileUrl = %@", fileUrl);
      
      [[[client.filesRoutes downloadUrl:dropboxpath overwrite:YES destination:fileUrl]
          setResponseBlock:^(DBFILESFileMetadata *dResult, DBFILESDownloadError *routeError, DBRequestError *networkError,
                             NSURL *destination) {
            if (dResult) {
                NSLog(@"%@\n", dResult);
                result(@(TRUE));

            } else {
                NSLog(@"ERROR!! %@\n%@\n", routeError, networkError);
                result(@(FALSE));

            }
          }] setProgressBlock:^(int64_t bytesDownloaded, int64_t totalBytesDownloaded, int64_t totalBytesExpectedToDownload) {
              [channel invokeMethod:@"progress" arguments:@[key, @(totalBytesDownloaded), @(totalBytesExpectedToDownload)]];

      }];
  } else {
      NSLog(@"%@", call.method);
      NSLog(@"%@", call.arguments);
      result(@(TRUE));
//    result(FlutterMethodNotImplemented);
  }
}

- (NSMutableArray*) parseEntries: (NSArray<DBFILESMetadata *> *)entries {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyyMMdd HHmmss";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (DBFILESMetadata *entry in entries) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setValue:entry.name forKey:@"name"];
        [dict setValue:entry.pathLower forKey:@"pathLower"];
        [dict setValue:entry.pathDisplay forKey:@"pathDisplay"];
        
        if ([entry isKindOfClass:[DBFILESFolderMetadata class]]) {

        } else if ([entry isKindOfClass:[DBFILESFileMetadata class]]) {
            DBFILESFileMetadata *fileItem = (DBFILESFileMetadata *) entry;
            [dict setObject:fileItem.size forKey:@"filesize"];
            [dict setObject:[formatter stringFromDate: fileItem.clientModified] forKey:@"clientModified"];
            [dict setObject:[formatter stringFromDate: fileItem.serverModified] forKey:@"serverModified"];
        }
        [arr addObject:dict];
    }

    return arr;
}

- (void) listFolderContinue: (NSString *)cursor result:(FlutterResult) result array:(NSMutableArray*) arr {
    DBUserClient *client = [DBClientsManager authorizedClient];

    [[client.filesRoutes listFolderContinue:cursor] setResponseBlock:^(DBFILESListFolderResult *response, DBFILESListFolderContinueError * _Nullable routeError, DBRequestError * _Nullable networkError) {
        if (response) {
            NSArray<DBFILESMetadata *> *entries = response.entries;
            NSString *cursor = response.cursor;
            BOOL hasMore = [response.hasMore boolValue];
            
            [arr addObjectsFromArray:[self parseEntries: entries]];

            if (hasMore) {
                [self listFolderContinue:cursor result:result array:arr];
            } else {
                NSLog(@"List folder complete. (with continue)");
                result(arr);
            }
        } else {
            NSLog(@"%@\n%@\n", routeError, networkError);
        }
    }];
}

@end
