#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([DBClientsManager respondsToSelector:@selector(handleRedirectURL:)]) {
        SEL selector = @selector(handleRedirectURL:);
        IMP imp = [DBClientsManager methodForSelector:selector];
        // + (DBOAuthResult *)handleRedirectURL:(NSURL *)url;
        DBOAuthResult *(*func)(id, SEL, NSURL *) = (void *)imp;
        DBOAuthResult *authResult = func([DBClientsManager class], selector, url);

        if (authResult != nil) {
            if ([authResult isSuccess]) {
                NSLog(@"Success! User is logged into Dropbox.");
            } else if ([authResult isCancel]) {
                NSLog(@"Authorization flow was manually canceled by user!");
            } else if ([authResult isError]) {
                NSLog(@"Error: %@", authResult);
            }
        }
    } else if ([DBClientsManager respondsToSelector:@selector(handleRedirectURL:completion:)]) {
        SEL selector = @selector(handleRedirectURL:completion:);
        IMP imp = [DBClientsManager methodForSelector:selector];
        // + (BOOL)handleRedirectURL:(NSURL *)url completion:(DBOAuthCompletion)completion;
        BOOL (*func)(id, SEL, NSURL *, DBOAuthCompletion) = (void *)imp;
        BOOL result = func([DBClientsManager class], selector, url, ^(DBOAuthResult *authResult) {
            if (authResult != nil) {
                if ([authResult isSuccess]) {
                    NSLog(@"Success! User is logged into Dropbox.");
                } else if ([authResult isCancel]) {
                    NSLog(@"Authorization flow was manually canceled by user!");
                } else if ([authResult isError]) {
                    NSLog(@"Error: %@", authResult);
                }
            }
        });
        if (result==FALSE) {
            NSLog(@"handleRedirectURL: completion: failed");
        }

    }

    return NO;
}

@end
