//
//  WBTabBar.h
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBarController;

typedef NS_ENUM(NSUInteger, WBTabBarCenterItemClickType) {
    WBTabBarCenterItemClickTypeTap,
    WBTabBarCenterItemClickTypePress
};

typedef void(^WBTabBarClickBlock)(WBTabBarCenterItemClickType type);

@interface WBTabBar : UITabBar

- (void)setCenterItemWithImage:(UIImage *)image
                   selectImage:(UIImage *)selImage
                 clickCallback:(WBTabBarClickBlock)block;


/************************Badge number******************************/

- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index;

- (NSInteger)badgeNumberAtIndex:(NSInteger)index;

@end
