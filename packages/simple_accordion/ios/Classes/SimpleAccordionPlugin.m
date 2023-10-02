#import "SimpleAccordionPlugin.h"
#if __has_include(<simple_accordion/simple_accordion-Swift.h>)
#import <simple_accordion/simple_accordion-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "simple_accordion-Swift.h"
#endif

@implementation SimpleAccordionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleAccordionPlugin registerWithRegistrar:registrar];
}
@end
