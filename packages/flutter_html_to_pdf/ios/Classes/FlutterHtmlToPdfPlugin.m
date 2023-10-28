#import "FlutterHtmlToPdfPlugin.h"
#if __has_include(<flutter_html_to_pdf/flutter_html_to_pdf-Swift.h>)
#import <flutter_html_to_pdf/flutter_html_to_pdf-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_html_to_pdf-Swift.h"
#endif

@implementation FlutterHtmlToPdfPlugin
UIViewController *_viewController;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHtmlToPdfPlugin registerWithRegistrar:registrar];
}@end
