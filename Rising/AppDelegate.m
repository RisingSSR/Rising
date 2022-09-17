//
//  AppDelegate.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "AppDelegate.h"

#import "RisingRouter/RisingRouter+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [self.router controllerForRouterPath:@"main"];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
