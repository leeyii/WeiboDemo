//
//  AppDelegate.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "WBAppDelegate.h"
#import "WBTabBarController.h"


@interface WBAppDelegate ()

@end

@implementation WBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:WBScreenBounds];
    
    // init root vc
    WBTabBarController *tabbarVC = [WBTabBarController new];
    window.rootViewController = tabbarVC;
    
    [window makeKeyAndVisible];
    self.window = window;
   
    return YES;
    
}



@end
