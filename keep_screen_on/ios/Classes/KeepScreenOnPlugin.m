#import "KeepScreenOnPlugin.h"
#if __has_include(<keep_screen_on/keep_screen_on-Swift.h>)
#import <keep_screen_on/keep_screen_on-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keep_screen_on-Swift.h"
#endif

@implementation KeepScreenOnPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeepScreenOnPlugin registerWithRegistrar:registrar];
}
@end
