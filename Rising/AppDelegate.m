//
//  AppDelegate.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "AppDelegate.h"

#import "Rising Schedule/ScheduleController.h"
#import "RisingRouter+Schedule.h"

#import "WKViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    __block UIViewController *vc;
    [self.router handleScheduleBlock:^(id<ScheduleRouterProtocol>  _Nonnull make) {
        vc = [make controllerWithStylePush:YES panAllowed: YES];
    }];
//    vc = [[WKViewController alloc] init];
    
    self.window = [[UIWindow alloc] init];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
