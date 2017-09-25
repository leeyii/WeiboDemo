//
//  WBTabBarController.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBTabBar.h"
#import "WBNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (WBTabBarBadge)

- (BOOL)showBadgeValue {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setShowBadgeValue:(BOOL)showBadgeValue {
    objc_setAssociatedObject(self, @selector(showBadgeValue), @(showBadgeValue), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)tabbarBadgeNumber {
    // is in tabbarController viewControllers ?
    if (!self.tabBarController) {
        NSLog(@"vc isn't in tabbarController viewControllers");
        return 0;
    }
    NSInteger index = [self.tabBarController.viewControllers indexOfObject:self];
    NSInteger numbre = [(WBTabBarController *)self.tabBarController badgeNumberAtIndex:index];
    
    return numbre;
}

- (void)setTabbarBadgeNumber:(NSInteger)tabbarBadgeNumber {
    if (!self.tabBarController) {
        NSLog(@"vc isn't in tabbarController viewControllers");
        return;
    }
    
    NSInteger index = [self.tabBarController.viewControllers indexOfObject:self];
    [(WBTabBarController *)self.tabBarController setBadgeNumber:tabbarBadgeNumber atIndex:index type:!self.showBadgeValue];
}

@end

@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // custom tabbar
    WBTabBar *tabbar = [WBTabBar new];
    [self setValue:tabbar forKey:@"tabBar"];

    // add child viewControllers
    UINavigationController *home = [self childControllerWithTitle:@"微博"
                                                  normalImageName:@"tabbar_home"
                                                     selImageName:@"tabbar_home_selected"];
    UINavigationController *message = [self childControllerWithTitle:@"消息"
                                                     normalImageName:@"tabbar_message_center"
                                                        selImageName:@"tabbar_message_center_selected"];
    UINavigationController *discover = [self childControllerWithTitle:@"发现"
                                                  normalImageName:@"tabbar_discover"
                                                     selImageName:@"tabbar_discover_selected"];
    UINavigationController *profile = [self childControllerWithTitle:@"我"
                                                     normalImageName:@"tabbar_profile"
                                                        selImageName:@"tabbar_profile_selected"];
    
    self.viewControllers = @[home, message, discover, profile];
    
    [(WBTabBar *)self.tabBar setCenterItemWithImage:nil selectImage:nil clickCallback:^(WBTabBarCenterItemClickType type) {
        
    }];
    
    home.showBadgeValue = YES;
    
    home.tabbarBadgeNumber = 99;
    
    profile.showBadgeValue = NO;
    profile.tabbarBadgeNumber = 1;
     
}

- (UINavigationController *)childControllerWithTitle:(NSString *)title
                                     normalImageName:(NSString *)imageName
                                        selImageName:(NSString *)selImageName {
    WBNavigationController *vc = [WBNavigationController new];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    return vc;
}

#pragma mark - Badge number

- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index type:(WBTabBarBadgeType)type{
    [(WBTabBar *)self.tabBar setBadgeNumber:number atIndex:index badgeTyep:type];
}

- (NSInteger)badgeNumberAtIndex:(NSInteger)index {
    return [(WBTabBar *)self.tabBar badgeNumberAtIndex:index];
}


@end





