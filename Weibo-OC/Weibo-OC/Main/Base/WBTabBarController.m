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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
