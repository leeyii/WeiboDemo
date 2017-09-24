//
//  WBTabBarController.h
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTabBarController : UITabBarController

/**************************badge***************************/
/**
 设置 指定index viewController BadgeNumber

 @param number badge number
 @param index viewController index 从 0 开始
 */
- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index;

/**
 获取 指定index viewController BadgeNumber

 @param index  viewController index 从 0 开始
 @return badge number
 */
- (NSInteger)badgeNumberAtIndex:(NSInteger)index;

@end

@interface UIViewController (WBTabBarBadge)

@property (nonatomic, assign) NSInteger tabbarBadgeNumber;

@end


