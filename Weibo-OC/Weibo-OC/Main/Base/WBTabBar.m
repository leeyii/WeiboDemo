//
//  WBTabBar.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "WBTabBar.h"

#define kTabBarItemW                (WBScreenW / 5.f)
#define kBadgeViewTop               (3)
#define kBadgeViewCenterOffset      (5)
#define kBadgeViewH                 (12)

static const NSInteger kBadgeViewTag = 999;


@interface _WBTabBarItemBadgeInfo : NSObject

@property (nonatomic, assign) BOOL needRefresh;

@property (nonatomic, assign) WBTabBarBadgeType type;

@property (nonatomic, assign) NSInteger badgeNumber;

@property (nonatomic, weak) UILabel *badgeView;

@property (nonatomic, weak) UIView *tabbarButton;


@end

@implementation _WBTabBarItemBadgeInfo

@end;


@interface WBTabBar()

@property (nonatomic, copy)   WBTabBarClickBlock callback; ///< center click callback

@property (nonatomic, strong) UIButton           *centerView;

@end

@implementation WBTabBar {
    NSMutableDictionary              *_badgeInfos;
    BOOL                             _isHaveCenterItem; ///< show center item ?
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _badgeInfos = @{}.mutableCopy;
        
        _centerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_centerView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_centerView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateHighlighted];
        [_centerView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateHighlighted];
        [self addSubview:_centerView];
        
        [_centerView addTarget:self action:@selector(centerBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *pressG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_centerView addGestureRecognizer:pressG];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isHaveCenterItem) {
        NSInteger index = 0;
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                // change item frame
                if (index == 2) {
                    _centerView.frame = CGRectMake(kTabBarItemW * index, subView.wb_y, kTabBarItemW, subView.wb_h);
                    index++;
                }
                subView.wb_x = kTabBarItemW * index;
                subView.wb_w = kTabBarItemW;
                index++;
            }
        }
    }
    
    // change badge number
    
    [_badgeInfos enumerateKeysAndObjectsUsingBlock:^(NSString *key, _WBTabBarItemBadgeInfo *info, BOOL * _Nonnull stop) {
        if (info.needRefresh) {
            
            if (info.badgeNumber > 0) {
                info.badgeView.hidden = NO;
                CGFloat width = 0.0;
                CGFloat heigth = 0.0;
                NSString *numberStr;
                if (WBTabBarBadgeTypeDot == info.type) {
                    numberStr = @"";
                    width = 6;
                    heigth = 6;
                    info.badgeView.layer.cornerRadius = 3;
                } else {
                    numberStr = info.badgeNumber > 99 ? @"..." : @(info.badgeNumber).stringValue;
                    if (numberStr.length == 1) {
                        width = 12;
                    } else {
                        width = 15;
                    }
                    info.badgeView.layer.cornerRadius = 6;
                    heigth = kBadgeViewH;
                }
                
                info.badgeView.text = numberStr;
                UIView *tabbarButton = info.tabbarButton;
                info.badgeView.frame = CGRectMake(tabbarButton.wb_w / 2 + kBadgeViewCenterOffset, kBadgeViewTop, width, heigth);
            } else {
                info.badgeView.hidden = YES;
            }
            
            info.needRefresh = NO;
        }
    }];
}



#pragma mark - Public API

- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index badgeTyep:(WBTabBarBadgeType)type{
    _WBTabBarItemBadgeInfo *info = _badgeInfos[@(index).stringValue];
    if (!info) {
        info = [_WBTabBarItemBadgeInfo new];
        UIView *badgeSuperView = nil;
        NSInteger i = 0;
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                
                if (index == i) {
                    badgeSuperView = subView;
                    break;
                }
                i++;
            }
        }

        UILabel *badgeView = [self badgeViewAtView:badgeSuperView];
        info.badgeView = badgeView;
        info.tabbarButton = badgeSuperView;
        
        _badgeInfos[@(index).stringValue] = info;
    }
    info.type = type;
    if (info.badgeNumber != number) {
        info.badgeNumber = number;
        info.needRefresh = YES;
        [self setNeedsLayout];
    }
}

- (NSInteger)badgeNumberAtIndex:(NSInteger)index {
    _WBTabBarItemBadgeInfo *info = _badgeInfos[@(index).stringValue];
    if (!info) {
        return 0;
    }
    return info.badgeNumber;
}

- (void)setCenterItemWithImage:(UIImage *)image selectImage:(UIImage *)selImage clickCallback:(WBTabBarClickBlock)block {
    _isHaveCenterItem = YES;
    if (image) [self.centerView setImage:image forState:UIControlStateNormal];
    if (selImage) [self.centerView setImage:selImage forState:UIControlStateSelected];

    self.callback = block;
    [self setNeedsLayout];
}

#pragma mark - Action
- (void)centerBtnAction:(UIButton *)sender event:(UIEvent *)event {
    
    if (self.callback) {
        self.callback(WBTabBarCenterItemClickTypeTap);
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)sender {
    if (self.callback) {
        self.callback(WBTabBarCenterItemClickTypePress);
    }
}

#pragma mark - Override


#pragma mark - Private

/**
 get badge view at view
 if not exists badge view add it to super view

 @param superView target view
 @return badge view
 */
- (UILabel *)badgeViewAtView:(UIView *)superView {
    UILabel *badgeView = [superView viewWithTag:kBadgeViewTag];
    
    if (!badgeView) {
        
        // init badge view
        badgeView = [UILabel new];
        badgeView.font = [UIFont systemFontOfSize:9];
        badgeView.layer.cornerRadius = 6;
        badgeView.layer.masksToBounds = YES;
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.textColor = [UIColor whiteColor];
        badgeView.tag = kBadgeViewTag;
        badgeView.textAlignment = NSTextAlignmentCenter;
        badgeView.hidden = YES;
        badgeView.layer.zPosition = 1;
        [superView addSubview:badgeView];
    }
    return badgeView;
}

- (UIButton *)centerView {
    if (!_centerView) {
        _centerView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_centerView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_centerView setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateHighlighted];
        [_centerView setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateHighlighted];
        [self addSubview:_centerView];
        
        [_centerView addTarget:self action:@selector(centerBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *pressG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_centerView addGestureRecognizer:pressG];
    }
    return _centerView;
}

@end
