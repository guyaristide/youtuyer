#import "YoutuyerPlugin.h"
#import <youtuyer/youtuyer-Swift.h>

@implementation YoutuyerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYoutuyerPlugin registerWithRegistrar:registrar];
}
@end
