//
//  AppDelegate.m
//  Rising
//
//  Created by SSR on 2022/8/2.
//

#import "AppDelegate.h"

#import "MainController.h"

#import "WKViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    UIViewController *vc = [[MainController alloc] init];
    UIViewController *vc = [[WKViewController alloc] init];
    
    self.window = [[UIWindow alloc] init];
    
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
